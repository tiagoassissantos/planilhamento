class ItemElement < ApplicationRecord

  GAUGES = {
    "4_2" => 0.109,
    "5_0" => 0.154,
    "6_3" => 0.245,
    "8_0" => 0.395,
    "10_0" => 0.617,
    "12_5" => 0.963,
    "16_0" => 1.578,
    "20_0" => 2.466,
    "25_0" => 3.853,
    "32_0" => 6.313,
  }

  belongs_to :format
  #belongs_to :stage_item, optional: true

  before_save :calculate_quantity_weight
  after_save :calculate_item_weight

  def calculate_quantity_weight
    gauge_weight = GAUGES[gauge]
    weight_tmp = 0

    format_values.each do |key, value|
      weight_tmp = weight_tmp + ( value.to_f * gauge_weight )
    end

    self.weight = BigDecimal( (weight_tmp * quantity * 0.01).to_s ).round(2)
  end

  def calculate_item_weight
    StageItem.find(self.stage_item_id).update_quantity_weight
  end

  
end

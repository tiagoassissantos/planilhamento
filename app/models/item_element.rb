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

  before_save :calculate_weight

  def calculate_weight
    gauge_weight = GAUGES[gauge]
    weight_tmp = 0
    
    p '-------------------'
    p gauge
    p format_values
    p gauge_weight

    format_values.each do |key, value|
      weight_tmp = weight_tmp + ( value.to_f * gauge_weight )
    end

    self.weight = BigDecimal( (weight_tmp * quantity * 0.01).to_s ).round(2)
  end
end

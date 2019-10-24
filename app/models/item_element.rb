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
  belongs_to :stage_item

  before_save :calculate_quantity_weight, :define_sequential
  after_save :calculate_item_weight
  after_destroy :calculate_item_weight

  def calculate_quantity_weight
    gauge_weight = GAUGES[gauge]
    weight_tmp = 0

    format_values.each do |key, value|
      unless value['size'] == nil
        weight_tmp = weight_tmp + ( ( value['size'].to_f * gauge_weight ) * value['qnt'].to_f)
      end
    end

    self.weight = BigDecimal( (weight_tmp * quantity * 0.01).to_s ).round(2)
  end

  def calculate_item_weight
    stage_item = StageItem.find(self.stage_item_id) #.update_quantity_weight
    stage_item.save
  end

  def to_log
    { id: id, position: position, gauge: gauge, format_id: format_id }
  end

  def define_sequential
    construction = self.stage_item.construction_stage.construction

    sql = "select sequential from item_elements
          where stage_item_id in (
            select id from stage_items where construction_stage_id in (
              select id from construction_stages where construction_id = #{construction.id}
            )
          ) order by sequential desc"
    records_array = ActiveRecord::Base.connection.execute(sql)

    if records_array.ntuples > 0
      self.sequential = records_array[0]['sequential'] + 1
    else
      self.sequential = 1
    end
  end

end

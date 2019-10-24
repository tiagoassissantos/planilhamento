class ItemElement < ApplicationRecord

  GAUGES = {
    "4_2" =>  {'text': '4.2', 'weight': 0.109, 'steel': 'CA60'},
    "5_0" =>  {'text': '5.0', 'weight': 0.154, 'steel': 'CA60'},
    "6_3" =>  {'text': '6.3', 'weight': 0.245, 'steel': 'CA50'},
    "8_0" =>  {'text': '8.0', 'weight': 0.395, 'steel': 'CA50'},
    "10_0" => {'text': '10.0', 'weight': 0.617, 'steel': 'CA50'},
    "12_5" => {'text': '12.5', 'weight': 0.963, 'steel': 'CA50'},
    "16_0" => {'text': '16.0', 'weight': 1.578, 'steel': 'CA50'},
    "20_0" => {'text': '20.0', 'weight': 2.466, 'steel': 'CA50'},
    "25_0" => {'text': '25.0', 'weight': 3.853, 'steel': 'CA50'},
    "32_0" => {'text': '32.0', 'weight': 6.313, 'steel': 'CA50'},
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
        weight_tmp = weight_tmp + ( value['size'].to_f * gauge_weight[:weight] )
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

  def steel_type
    GAUGES[self.gauge][:steel]
  end

  def gauge_text
    GAUGES[self.gauge][:text]
  end
end

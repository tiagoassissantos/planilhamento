class ConstructionStage < ApplicationRecord
  has_many :stage_items

  def update_quantity
    stage_weight = 0
    
    items = StageItem.where( construction_stage_id: self.id )
    items.each do |item|
      p item.to_json
      stage_weight += item.weight
    end

    self.quantity = stage_weight
    self.save
  end
end

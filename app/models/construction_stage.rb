class ConstructionStage < ApplicationRecord
  belongs_to :construction
  has_many :stage_items, dependent: :destroy

  def update_quantity
    stage_weight = 0
    
    items = StageItem.where( construction_stage_id: self.id )
    items.each do |item|
      stage_weight += item.weight
    end

    self.quantity = stage_weight
    self.save
  end

  def to_log
    { id: id, name: name, construction_id: construction_id }
  end
end

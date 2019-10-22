class StageItem < ApplicationRecord
  belongs_to :construction_stage
  has_many :item_elements, dependent: :destroy

  before_save :update_quantity_weight
  after_save :calculate_stage_weight
  after_destroy :calculate_stage_weight

  def update_quantity_weight
    item_weight = 0
    elements = ItemElement.where( stage_item_id: self.id )
    
    elements.each do |element|
      item_weight += element.weight
    end

    self.weight = item_weight * self.quantity
  end

  def calculate_stage_weight
    ConstructionStage.find(self.construction_stage_id).update_quantity
  end

  def to_log
    { id: id, name: name, construction_stage_id: construction_stage_id }
  end
end

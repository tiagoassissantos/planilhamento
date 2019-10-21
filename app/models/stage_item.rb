class StageItem < ApplicationRecord
  has_many :item_elements, dependent: :destroy

  after_save :calculate_stage_weight
  after_destroy :calculate_stage_weight

  def update_quantity_weight
    self.quantity = self.item_elements.size

    item_weight = 0
    elements = ItemElement.where( stage_item_id: self.id )
    elements.each do |element|
      item_weight += element.weight
    end

    self.weight = item_weight
    self.save
  end

  def calculate_stage_weight
    ConstructionStage.find(self.construction_stage_id).update_quantity
  end
end

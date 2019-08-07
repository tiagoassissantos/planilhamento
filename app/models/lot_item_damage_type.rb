class LotItemDamageType < ApplicationRecord
  belongs_to :lot_item
  belongs_to :damage_type

  after_save :update_sku

  def update_sku
    self.lot_item.change_sku
  end
end
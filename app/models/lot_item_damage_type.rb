class LotItemDamageType < ApplicationRecord
  belongs_to :lot_item
  belongs_to :damage_type
end
class DamageType < ApplicationRecord
  belongs_to :hardware_type

  has_many :lot_item_damage_types
  has_many :lot_items, :through => :lot_item_damage_types

  has_many :sku_damage_types
  has_many :skus, :through => :sku_damage_types
end

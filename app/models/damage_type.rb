class DamageType < ApplicationRecord
  belongs_to :hardware_type
  has_and_belongs_to_many :lot_items
end

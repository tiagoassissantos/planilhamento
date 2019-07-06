class Sku < ApplicationRecord
  belongs_to :hardware_type
  belongs_to :manufacturer
  belongs_to :model
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  belongs_to :damage_type, optional: true
  has_one_attached :archive
end

class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :hardware_type
  belongs_to :model
  belongs_to :destination
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  belongs_to :damage_type, optional: true
end

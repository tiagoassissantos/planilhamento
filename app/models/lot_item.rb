class LotItem < ApplicationRecord
  belongs_to :hardware_type
  belongs_to :model
end

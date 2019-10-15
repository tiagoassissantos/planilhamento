class Construction < ApplicationRecord
  has_one :customer
  has_many :stage_constructions
end

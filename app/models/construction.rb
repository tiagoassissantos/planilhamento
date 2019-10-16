class Construction < ApplicationRecord
  belongs_to :customer
  has_many :stage_constructions
end

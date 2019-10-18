class Construction < ApplicationRecord
  belongs_to :customer
  has_many :construction_stages
end

class Lot < ApplicationRecord
  has_many :lot_items

  enum status: [:open, :closed, :reopened]
end

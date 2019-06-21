class SalesOrder < ApplicationRecord
  has_many :lot_items
end

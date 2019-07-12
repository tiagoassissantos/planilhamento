class SkuDamageType < ApplicationRecord
  belongs_to :sku
  belongs_to :damage_type
end

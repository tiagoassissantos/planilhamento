class DamageTypeSerializer < ActiveModel::Serializer
  belongs_to :hardware_type

  attributes :id, :name, :hardware_type
end

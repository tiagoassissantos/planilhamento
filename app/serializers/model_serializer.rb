class ModelSerializer < ActiveModel::Serializer
  belongs_to :manufacturer

  attributes :id, :name, :manufacturer
end

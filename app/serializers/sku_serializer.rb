class SkuSerializer < ActiveModel::Serializer
  attributes :id, :code, :hardware_type, :manufacturer, :model

  has_one :hardware_type
  has_one :manufacturer
  has_one :model

  def hardware_type
    return object.hardware_type.name
  end

  def manufacturer
    return object.manufacturer.name
  end

  def model
    return object.model.name
  end
end

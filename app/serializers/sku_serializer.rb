class SkuSerializer < ActiveModel::Serializer
  attributes :id, :code, :hardware_type, :manufacturer, :model, :ram_memory,
             :archive, :damages

  has_one :hardware_type
  has_one :manufacturer
  has_one :model
  has_one :archive

  def hardware_type
    return object.hardware_type.name
  end

  def manufacturer
    return object.manufacturer.name
  end

  def model
    return object.model.name
  end

  def category
    return object.category.name
  end

  def damages
    dams = []
    object.damage_types.each do |damage|
      dams << damage.name
    end
    return dams
  end

  def archive
    if object.archive.attached?
      url = 'http://'+ ENV["url"] + Rails.application.routes.url_helpers.rails_blob_path( object.archive, disposition: "attachment" )
      return url
    else
      return 'false'
    end
  end
end

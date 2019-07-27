class SkuSerializer < ActiveModel::Serializer
  attributes :id, :code, :hardware_type, :manufacturer, :model, :ram_memory,
             :archive, :damages, :category, :processor, :disk_size, :disk_type, :webcam, :keyboard_type

  has_one :hardware_type
  has_one :manufacturer
  has_one :model
  has_one :archive
  has_one :category
  has_one :processor
  has_one :disk_size
  has_one :disk_type
  has_one :keyboard_type

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
    unless object.category.nil?
      return object.category.name
    else
      return ''
    end
  end

  def damages
    dams = []
    object.damage_types.each do |damage|
      dams << damage.name
    end
    return dams
  end

  def processor
    unless object.processor.nil?
      return object.processor.name
    else
      return ''
    end
  end

  def archive
    if object.archive.attached?
      url = 'http://'+ ENV["url"] + Rails.application.routes.url_helpers.rails_blob_path( object.archive, disposition: "attachment" )
      return url
    else
      return 'false'
    end
  end

  def disk_size
    unless object.disk_size.nil?
      return object.disk_size.name
    else
      return ''
    end
  end

  def disk_type
    unless object.disk_size.nil?
      return object.disk_size.name
    else
      return ''
    end
  end

  def webcam
    case object.webcam
    when '12'
      return 'Sim'
    when '13'
      return 'Não'
    else
      return ' '
    end
  end

  def keyboard_type
    unless object.keyboard_type.nil?
      return object.keyboard_type.name
    else
      return ''
    end
  end

end

class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :hardware_type
  belongs_to :model
  belongs_to :destination
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  belongs_to :damage_type, optional: true
  belongs_to :sku, optional: true

  after_save :generate_sku


  def generate_sku
    return unless this.sku.nil?

    case hardware_type.id
    when 1
      generate_monitor_sku()
    when 2
      generate_desktop_Sku()
    when 3
      generate_server_sku()
    when 4
      generate_notebook_sku()
    when 5
      generate_celular_sku()
    when 6
      generate_tablet_sku()
    when 7
      generate_switch_sku()
    when 8
      generate_hd_sku()
    when 9
      generate_ssd_sku()
    when 10
      generate_others_sku()
    end
  end

  def generate_monitor_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s

    code
  end

  def generate_desktop_sku
  end

  def generate_server_sku
  end

  def generate_notebook_sku
  end

  def generate_celular_sku
  end

  def generate_tablet_sku
  end

  def generate_switch_sku
  end

  def generate_hd_sku
  end

  def generate_ssd_sku
  end

  def generate_others_sku
  end
end

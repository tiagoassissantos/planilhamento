class Sku < ApplicationRecord
  belongs_to :hardware_type
  belongs_to :manufacturer
  belongs_to :model
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  #belongs_to :damage_type, optional: true
  has_one_attached :archive

  has_many :sku_damage_types
  has_many :damage_types, :through => :sku_damage_types


  def generate_sku_uid
    code = generate_base_sku_code

    case hardware_type.id
    when 1 # monitor
      code += category.id.to_s
      code += generate_code_damage

    when 2 # desktop

    when 3 # server

    when 4 # notebook

    when 5 # celular

    when 6 # tablet

    when 7 # switch

    when 8 # hd

    when 9 # ssd

    when 10...+1.0/0.0

    end

    code
  end


  def generate_base_sku_code
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code
  end


  def generate_code_damage
    code = ''
    damage_types.sort_by{|d| d.id}.each do |damage|
      code += damage.id.to_s
    end
    return code
  end
end

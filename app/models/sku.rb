class Sku < ApplicationRecord
  belongs_to :hardware_type
  #belongs_to :manufacturer
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

  after_create :generate_sku_code


  def find_or_create
    code = generate_sku_uid
    sku = Sku.find_by(uid: code)

    if sku.nil?
      self.uid = code
      self.save
      sku = self
    end

    sku
  end


  def generate_sku_uid
    code = generate_base_sku_code

    case hardware_type.id
    when 1 # monitor
      code += category.id.to_s
      code += generate_code_damage

    when 2 # desktop
      code += category.id.to_s
      code += processor.id.to_s
      code += vga_card
      code += generate_code_damage

    when 3 # server
      code += category.id.to_s
      code += processor.id.to_s
      code += generate_code_damage

    when 4 # notebook
      code += category.id.to_s
      code += processor.id.to_s
      code += webcam
      code += keyboard_type.id.to_s
      code += bluetooth
      code += bright_keyboard
      code += biometric_reader
      code += vga_card
      code += generate_code_damage

    when 5 # celular
      code += ram_memory
      code += category.id.to_s
      code += disk_size.id.to_s
      code += color[0,4]
      code += generate_code_damage

    when 6 # tablet
      code += ram_memory
      code += category.id.to_s
      code += color[0,4]
      code += generate_code_damage

    when 7 # switch
      code += category.id.to_s
      code += generate_code_damage

    when 8, 9 # hd ssd
      code += disk_size.id.to_s
      code += disk_type.id.to_s
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
    code = 'DT'
    damage_types.sort_by{|d| d.id}.each do |damage|
      code += damage.id.to_s
    end
    return code
  end

  def generate_sku_code
    self.code = self.id
    self.save
  end
end

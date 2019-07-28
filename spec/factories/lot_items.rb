FactoryBot.define do
  factory :lot_item_monitor, class: LotItem do
    lot {create(:lot_1)}
    #sku nil
    hardware_type { HardwareType.first }
    model {create(:model_1)}
    serial_number { '1234' }
    asset_tag { '' }
    bar_code { '1234' }
    destination { Destination.first }
    category {create(:category_1)}
    comments { 'Teste' }
    damage_types { [DamageType.find_by(name: 'Placa - NÃO LIGA')] }
    #sales_order_id
  end

  factory :lot_item_monitor_2_damages, class: LotItem do
    lot {create(:lot_1)}
    #sku nil
    hardware_type { HardwareType.first }
    model {create(:model_1)}
    serial_number { '1234' }
    asset_tag { '' }
    bar_code { '1234' }
    destination { Destination.first }
    category {create(:category_1)}
    comments { 'Teste' }
    damage_types { [
      DamageType.find_by(hardware_type_id: 1, name:'Placa - VGA QUEBRADO'),
      DamageType.find_by(hardware_type_id: 1, name: 'Placa - NÃO LIGA')
    ] }
  end


  factory :lot_item_all, class: LotItem do
    lot {create(:lot_1)}
    #sku nil
    hardware_type { HardwareType.first }
    model {create(:model_1)}
    serial_number { '1234' }
    category {create(:category_1)}
    damage_types { [DamageType.find_by(name: 'Placa - NÃO LIGA')] }

    processor {create(:processor_1)}
    disk_type {create(:hdd)}
    disk_size {create(:disk_size_1)}
    destination { Destination.first }
    keyboard_type { create(:kt_abnt_2) }
    #sales_order_id
    #parent_id
    ram_memory { '' }
    asset_tag { '123' }
    comments { 'Teste' }
    screen { '123' }
    webcam { 'false' }
    bluetooth { 'false' }
    bright_keyboard { 'false' }
    bar_code { '1234' }
    biometric_reader { 'false' }
    vga_card { 'false' }
    color { 'azul' }
  end
end

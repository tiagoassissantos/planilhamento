FactoryBot.define do
  factory :sku_monitor, class: Sku do
    hardware_type { HardwareType.find(1) }
    model {create(:model_1)}
    category {create(:category_1)}
    damage_types { [DamageType.find_by(hardware_type_id: 1, name: 'Placa - NÃO LIGA')] }
  end

  factory :sku_monitor_2_damages, class: Sku do
    hardware_type { HardwareType.first }
    model {create(:model_1)}
    category {create(:category_1)}
    damage_types { [
      DamageType.find_by(hardware_type_id: 1, name:'Placa - VGA QUEBRADO'),
      DamageType.find_by(hardware_type_id: 1, name: 'Placa - NÃO LIGA')
    ] }
  end

  factory :sku_monitor_without_damages, class: Sku do
    hardware_type { HardwareType.first }
    model {create(:model_1)}
    category {create(:category_1)}
  end

  factory :sku_desktop, class: Sku do
    hardware_type { HardwareType.find(2) }
    model {create(:model_1)}
    category {create(:category_1)}
    damage_types { [DamageType.find_by(hardware_type_id: 2, name:'Placa Mãe - NÃO LIGA')] }
    processor {create(:processor_1)}
    vga_card {0}
  end

  factory :sku_server, class: Sku do
    hardware_type { HardwareType.find(3) }
    model {create(:model_1)}
    category {create(:category_1)}
    damage_types { [DamageType.find_by(hardware_type_id: 3, name:'Placa Mãe - NÃO LIGA')] }
    processor {create(:processor_1)}
  end

  factory :sku_notebook, class: Sku do
    hardware_type { HardwareType.find(4) }
    model {create(:model_1)}
    category {create(:category_1)}
    damage_types { [DamageType.find_by(hardware_type_id: 4, name:'Placa Mãe - NÃO LIGA')] }
    processor {create(:processor_1)}
    webcam {1}
    keyboard_type { create(:kt_abnt_2) }
    bluetooth {1}
    bright_keyboard {0}
    biometric_reader { 0 }
    vga_card {0}
  end

  factory :sku_smartphone, class: Sku do
    hardware_type { HardwareType.find(5) }
    model {create(:model_1)}
    ram_memory { '1GB' }
    category {create(:category_1)}
    damage_types { [DamageType.find_by(hardware_type_id: 5, name:'NÃO LIGA')] }
    disk_size {create(:disk_size_1)}
    color {'Preto'}
  end

  factory :sku_hdd, class: Sku do
    hardware_type { HardwareType.find(8) }
    model {create(:model_1)}
    disk_size {create(:disk_size_1)}
    disk_type {create(:hdd)}
  end

  factory :sku_other, class: Sku do
    hardware_type { HardwareType.find(10) }
    model {create(:model_1)}
  end
end

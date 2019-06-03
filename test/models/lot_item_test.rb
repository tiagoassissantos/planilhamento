require 'test_helper'

class LotItemTest < ActiveSupport::TestCase
  test "generate monitor sku" do
    lot_item = LotItem.new
    lot_item.hardware_type = HardwareType.create(name: 'Monitor')
    model = Model.create(name: 'Teste', manufacturer: Manufacturer.create(name: 'Fabricante'))
    lot_item.model = model

    lot_item.category = Category.create(name: 'Categoria 1')

    p lot_item.generate_monitor_sku
  end
end

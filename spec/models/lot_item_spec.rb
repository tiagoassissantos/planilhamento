require 'rails_helper'

RSpec.describe LotItem, type: :model do
  context 'creating lot_item'do
    it 'create monitor' do
      create(:lot_item_monitor)
      lot_item = LotItem.first
      expect(lot_item.hardware_type.name).to eq('Monitor')
    end
  end

  context 'generate sku'do
    it 'create SKU to monitor' do
      create(:lot_item_monitor)
      lot_item = LotItem.first
      expect(lot_item.sku.code).not_to be_nil
    end

    it 'create SKU to monitor with damages' do
      create(:lot_item_monitor)
      lot_item = LotItem.first
      expect(lot_item.sku.damage_types).not_to be_empty
    end
  end


  context 'do not generate SKU' do
    it 'if sku already exists' do
      lot_item = build(:lot_item_monitor_2_damages)

      lot_item1 = lot_item
      lot_item.save

      lot_item2 = lot_item
      lot_item2.save

      expect(lot_item1.sku.code).to eq(lot_item2.sku.code)
    end
  end
end

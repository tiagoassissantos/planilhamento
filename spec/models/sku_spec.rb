require 'rails_helper'

RSpec.describe Sku, type: :model do
  context 'generate monitor sku uid' do
    it 'generate uid to monitor' do
      sku_monitor = build(:sku_monitor)
      uid = sku_monitor.generate_sku_uid
      code = "Mon#{sku_monitor.model.manufacturer.id}#{sku_monitor.model.id}#{sku_monitor.category.id}#{sku_monitor.damage_types[0].id}"
      expect(uid).to eq(code)
    end

    it 'generate uid to monitor with 2 damages' do
      sku_monitor = build(:sku_monitor_2_damages)
      uid = sku_monitor.generate_sku_uid
      code = "Mon#{sku_monitor.model.manufacturer.id}#{sku_monitor.model.id}#{sku_monitor.category.id}#{sku_monitor.damage_types[1].id}#{sku_monitor.damage_types[0].id}"
      expect(uid).to eq(code)
    end
  end


  context 'generate desktop sku uid' do
    it 'generate uid to desktop' do
      sku = build(:sku_desktop)
      uid = sku.generate_sku_uid
      code = "Des#{sku.model.manufacturer.id}#{sku.model.id}#{sku.category.id}#{sku.damage_types[0].id}#{sku.processor.id}#{sku.vga_card}"
      expect(uid).to eq(code)
    end
  end


  context 'generate server sku uid' do
    it 'generate uid' do
      sku = build(:sku_server)
      uid = sku.generate_sku_uid
      code = "Ser#{sku.model.manufacturer.id}#{sku.model.id}#{sku.category.id}#{sku.damage_types[0].id}#{sku.processor.id}"
      expect(uid).to eq(code)
    end
  end


  context 'generate notebook sku uid' do
    it 'generate uid' do
      sku = build(:sku_notebook)
      uid = sku.generate_sku_uid
      code = "Not#{sku.model.manufacturer.id}#{sku.model.id}#{sku.category.id}#{sku.damage_types[0].id}#{sku.processor.id}#{sku.webcam}#{sku.keyboard_type.id}#{sku.bluetooth}#{sku.bright_keyboard}#{sku.biometric_reader}#{sku.vga_card}"
      expect(uid).to eq(code)
    end
  end

  context 'generate smartphone sku uid' do
    it 'generate uid' do
      sku = build(:sku_smartphone)
      uid = sku.generate_sku_uid
      code = "Cel#{sku.model.manufacturer.id}#{sku.model.id}#{sku.ram_memory}#{sku.category.id}#{sku.damage_types[0].id}#{sku.disk_size.id}#{sku.color[0,4]}"
      expect(uid).to eq(code)
    end
  end

  context 'generate hdd sku uid' do
    it 'generate uid' do
      sku = build(:sku_hdd)
      uid = sku.generate_sku_uid
      code = "HDD#{sku.model.manufacturer.id}#{sku.model.id}#{sku.disk_size.id}#{sku.disk_type.id}"
      expect(uid).to eq(code)
    end
  end

  context 'generate other sku uid' do
    it 'generate uid' do
      sku = build(:sku_other)
      uid = sku.generate_sku_uid
      code = "Out#{sku.model.manufacturer.id}#{sku.model.id}"
      expect(uid).to eq(code)
    end
  end


  context 'save sku' do
    it 'create new sku with uid' do
      sku = build(:sku_desktop)
      sku2 = sku.find_or_create
      expect(sku2.uid).not_to be_nil
    end

    it 'do not create new sku when sku already exists' do
      sku = build(:sku_desktop)
      sku1 = sku.find_or_create
      sku2 = sku.find_or_create
      expect(sku2.uid).to eq(sku1.uid)
    end


    it 'do not create new sku with 2 damages when sku already exists' do
      sku = build(:sku_monitor_2_damages)
      sku1 = sku.find_or_create
      sku2 = sku.find_or_create
      expect(sku2.uid).to eq(sku1.uid)
    end
  end
end

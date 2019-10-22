require 'rails_helper'

RSpec.describe StageItem, type: :model do
  context 'calculate item weight' do
    it 'item with 1 element' do
      stage_item = create( :stage_item, quantity: 1 )
      create(:item_element, stage_item: stage_item)
      stage_item.save #update_quantity_weight

      expect( stage_item.weight ).to eq( 0.15 )
    end

    it 'item with 2 elements' do
      stage_item = create( :stage_item, quantity: 1 )
      create(:item_element, stage_item: stage_item)
      create(:item_element, stage_item: stage_item)
      stage_item.save #update_quantity_weight

      expect( stage_item.weight ).to eq( 0.30 )
    end

    it 'item with 2 elements and item quantity 2' do
      stage_item = create( :stage_item, quantity: 2 )
      create(:item_element, stage_item: stage_item)
      create(:item_element, stage_item: stage_item)
      stage_item.save #update_quantity_weight

      expect( stage_item.weight ).to eq( 0.60 )
    end
  end
end

require 'rails_helper'

RSpec.describe ItemElement, type: :model do
  let(:format_1) { create( :format_one ) }
  let(:format_8) { create( :format_eight ) }
  let(:stage_item) { create( :stage_item ) }
  
  context "calculate_weight" do
    it 'sould calculate weight to format with 1 side' do
      element = ItemElement.create( 
        gauge: "10_0", quantity: 4, 
        format_values: {"l1": {"qnt": 1, "size": "300"}}, 
        format: format_1, stage_item: stage_item )
      expect( element.weight ).to eq( 7.40 )
    end

    it 'sould calculate weight to format with 4 sides' do
      format_values = {
        "l1": {"qnt": 2, "size": "10"},
        "l2": {"qnt": 2, "size": "20"},
        "l3": {"qnt": 1, "size": "5"}
      }
      element = ItemElement.create( gauge: "4_2", quantity: 14, format_values: format_values, format: format_8, stage_item: stage_item )
      expect( element.weight ).to eq( 0.99 )
    end
  end

  context 'certify StageItem.update_quantity_weight will be call' do
    it 'should call' do
      ItemElement.create( gauge: "10_0", quantity: 4, format_values: {"l1": {"qnt": 1, "size": "300"}}, format: format_1, stage_item: stage_item )

      expect( stage_item.reload.weight ).to eq( 7.40 )
    end
  end
end

require 'rails_helper'

RSpec.describe ItemElement, type: :model do
  let(:format_1) { create( :format_one ) }
  let(:format_5) { create( :format_five ) }
  let(:stage_item) { create( :stage_item ) }
  
  context "calculate_weight" do
    it 'sould calculate weight to format with 1 side' do
      element = ItemElement.create( gauge: "10_0", quantity: 4, format_values: {"A": 300}, format: format_1, stage_item: stage_item )
      expect( element.weight ).to eq( 7.40 )
    end

    it 'sould calculate weight to format with 4 sides' do
      format_values = {"A": 10, "B": 20, "C": 10, "D": 20}
      element = ItemElement.create( gauge: "4_2", quantity: 14, format_values: format_values, format: format_5, stage_item: stage_item )
      expect( element.weight ).to eq( 0.92 )
    end
  end

  context 'certify StageItem.update_quantity_weight will be call' do
    it 'should call' do
      element = ItemElement.create( gauge: "10_0", quantity: 4, format_values: {"A": 300}, format: format_1, stage_item: stage_item )

      expect( stage_item.reload.weight ).to eq( 7.40 )
    end
  end
end

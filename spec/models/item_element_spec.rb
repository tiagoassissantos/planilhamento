require 'rails_helper'

RSpec.describe ItemElement, type: :model do
  context "calculate_weight" do
    it 'sould calculate weight to format with 1 side' do
      format = create( :format_one )
      element = ItemElement.create( position: 1, gauge: "10_0", quantity: 4, format_values: {"A": 300}, format: format )
      expect( element.weight ).to eq( 7.40 )
    end

    it 'sould calculate weight to format with 4 sides' do
      format = create( :format_five )
      format_values = {"A": 10, "B": 20, "C": 10, "D": 20}
      element = ItemElement.create( position: 1, gauge: "4_2", quantity: 14, format_values: format_values, format: format )
      expect( element.weight ).to eq( 0.92 )
    end

  end
end

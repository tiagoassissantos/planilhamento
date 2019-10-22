FactoryBot.define do
  factory :stage_item, class: StageItem do
    construction_stage {create(:construction_stage)}
    name { "Item 1" }
    abbreviation { "IT1" }
    quantity {1}
    weight {0}
  end
end

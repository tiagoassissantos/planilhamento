FactoryBot.define do
  factory :item_element do
    position { 1 }
    gauge { "5_0" }
    quantity { 1 }
    format_values { {"l1": {"qnt": 1, "size": "100"}} }
    #weight { 0.15 }
    format { create(:format_one) }
  end
end

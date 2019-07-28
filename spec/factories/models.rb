FactoryBot.define do
  factory :model_1, class: Model do
    name {'Model 1'}
    manufacturer {create(:manufacturer_1)}
  end
end

FactoryBot.define do
  factory :construction, class: Construction do
    customer {create(:client)}
    name {'Obra 1'}
  end
end

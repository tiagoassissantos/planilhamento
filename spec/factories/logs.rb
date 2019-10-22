FactoryBot.define do
  factory :log do
    user { nil }
    action { "MyString" }
    description { "MyText" }
  end
end

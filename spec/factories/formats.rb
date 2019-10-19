FactoryBot.define do
  factory :format_one, class: Format do
    name { "Format 1" }
    sides { 1 }
  end

  factory :format_five, class: Format do
    name { "Format 5" }
    sides { 4 }
  end
end

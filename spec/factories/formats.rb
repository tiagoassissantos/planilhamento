FactoryBot.define do
  factory :format_one, class: Format do
    name { 'Format 1' }
    sides { 1 }
    image_name { 'Format-1' }
  end

  factory :format_three, class: Format do
    name { 'Format 3' }
    sides { 2 }
    image_name { 'Format-3' }
  end

  factory :format_four, class: Format do
    name { 'Format 4' }
    sides { 3 }
    image_name { 'Format-4' }
  end

  factory :format_eight, class: Format do
    name { 'Format 8' }
    sides { 3 }
    image_name { 'Format-8' }
  end

  factory :format_five_eight, class: Format do
    name { 'Format 58' }
    sides { 2 }
    image_name { 'Format-58' }
  end

  factory :format_one_two_two, class: Format do
    name { 'Format 122' }
    sides { 1 }
    image_name { 'Format-122' }
  end

  factory :format_two_four_five, class: Format do
    name { "Format 245" }
    sides { 4 }
    image_name { 'Format-245' }
  end
end

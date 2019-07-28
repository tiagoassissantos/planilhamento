FactoryBot.define do
  factory :ssd, class: DiskType do
    name {'SSD'}
  end

  factory :hdd, class: DiskType do
    name {'HDD'}
  end
end

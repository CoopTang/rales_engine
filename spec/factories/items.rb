FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "item_#{n}"
    end
    sequence :description do |n|
      "item_description_#{n}"
    end
    unit_price { 1 }
    merchant { nil }
  end
end

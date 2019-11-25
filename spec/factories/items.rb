FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "item_#{n}"
    end
    sequence :description do |n|
      "item_description_#{n}"
    end
    sequence :unit_price do |n|
      n
    end
    merchant { nil }
  end
end

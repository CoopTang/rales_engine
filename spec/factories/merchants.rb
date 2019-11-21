FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "merchant_#{n}" }

    factory :merchant_with_items do
      sequence(:name) { |n| "merchant_#{n}" }
      after :create do |merchant|
        create_list(:item, 3, merchant: merchant)
      end
    end
  end
end

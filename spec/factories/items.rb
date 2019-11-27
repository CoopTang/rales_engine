FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "item_#{n}" }
    sequence(:description) { |n| "item_description_#{n}" }
    sequence(:unit_price) { |n| n }
    merchant

    factory :item_with_invoices do
      sequence(:name) { |n| "item_#{n}" }
      sequence(:description) { |n| "item_description_#{n}" }
      sequence(:unit_price) { |n| n }
      after :create do |item|
        create_list(:invoice_item, 3, item: item)
      end
    end
  end
end

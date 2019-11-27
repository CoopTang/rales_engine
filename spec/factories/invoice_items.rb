FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    sequence(:quantity) { |n| n }
    sequence(:unit_price) { |n| n }
  end
end

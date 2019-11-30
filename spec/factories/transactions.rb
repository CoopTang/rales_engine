FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| "credit_card_number_#{n}" }
    credit_card_expiration_date { "" }
    result { "success" }
  end
end

FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant_references { "MyString" }
    status { "MyString" }
  end
end

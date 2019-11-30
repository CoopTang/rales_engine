FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "success" }

    factory :invoice_with_transactions do
      customer
      merchant
      status { "success" }
      after :create do |invoice|
        create_list(:transaction, 3, invoice: invoice)
      end
    end
  end
end

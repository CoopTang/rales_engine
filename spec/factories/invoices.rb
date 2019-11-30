FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "shipped" }

    factory :invoice_with_transactions do
      customer
      merchant
      status { "shipped" }
      after :create do |invoice|
        create_list(:transaction, 3, invoice: invoice)
      end
    end

    factory :invoice_with_items do
      customer
      merchant
      status { "shipped" }
      after :create do |invoice|
        create_list(:item, 3, merchant: invoice.merchant)
      end
    end

    factory :invoice_with_invoice_items do
      customer
      merchant
      status { "shipped" }
      after :create do |invoice|
        create_list(:invoice_item, 3, invoice: invoice)
      end
    end
  end
end

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
        item_1 = create(:item, merchant: invoice.merchant)
        item_2 = create(:item, merchant: invoice.merchant)
        item_3 = create(:item, merchant: invoice.merchant)

        create(:invoice_item, item: item_1, invoice: invoice)
        create(:invoice_item, item: item_2, invoice: invoice)
        create(:invoice_item, item: item_3, invoice: invoice)
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

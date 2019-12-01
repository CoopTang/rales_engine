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
      merchant
      after :create do |item|
        create_list(:invoice_item, 3, item: item)
      end
    end

    factory :item_with_transactions do
      sequence(:name) { |n| "item_#{n}" }
      sequence(:description) { |n| "item_description_#{n}" }
      sequence(:unit_price) { |n| n }
      merchant
      after :create do |item|
        invoice_1 = create(:invoice, merchant: item.merchant)
        invoice_item_1 = create(
          :invoice_item,
          item: item,
          invoice: invoice_1,
          unit_price: item.unit_price
        )
        transaction_1 = create(
          :transaction,
          invoice: invoice_1
        )
        transaction_2 = create(
          :transaction,
          invoice: invoice_1,
          result: 'failed'
        )
        transaction_3 = create(
          :transaction,
          invoice: invoice_1
        )

        invoice_2 = create(:invoice, merchant: item.merchant)
        invoice_item_2 = create(
          :invoice_item,
          item: item,
          invoice: invoice_2,
          unit_price: item.unit_price
        )
        transaction_4 = create(
          :transaction,
          invoice: invoice_2
        )
        transaction_5 = create(
          :transaction,
          invoice: invoice_2,
          result: 'failed'
        )
        transaction_6 = create(
          :transaction,
          invoice: invoice_2
        )

        invoice_3 = create(:invoice, merchant: item.merchant)
        invoice_item_3 = create(
          :invoice_item,
          item: item,
          invoice: invoice_3,
          unit_price: item.unit_price
        )
        transaction_7 = create(
          :transaction,
          invoice: invoice_3
        )
        transaction_8 = create(
          :transaction,
          invoice: invoice_3,
          result: 'failed'
        )
        transaction_9 = create(
          :transaction,
          invoice: invoice_3
        )
      end
    end
  end
end

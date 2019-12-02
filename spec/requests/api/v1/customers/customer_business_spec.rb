require 'rails_helper'

RSpec.describe 'Customer Business Intelligence API:' do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'favorite_merchant' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    merchant_1_item = create(:item, merchant: merchant_1)
    merchant_2_item = create(:item, merchant: merchant_2)

    customer_1 = create(:customer)
    invoice_1 = create(
      :invoice,
      customer: customer_1,
      merchant: merchant_2
    )
    invoice_item_1 = create(
      :invoice_item,
      invoice: invoice_1,
      item: merchant_2_item
    )
    transaction_1 = create(
      :transaction,
      invoice: invoice_1,
      result: 'failed'
    )
    invoice_2 = create(
      :invoice,
      customer: customer_1,
      merchant: merchant_2
    )
    invoice_item_2 = create(
      :invoice_item,
      invoice: invoice_2,
      item: merchant_2_item
    )
    transaction_2 = create(
      :transaction,
      invoice: invoice_2,
      result: 'failed'
    )
    invoice_3 = create(
      :invoice,
      customer: customer_1,
      merchant: merchant_1
    )
    invoice_item_3 = create(
      :invoice_item,
      invoice: invoice_3,
      item: merchant_1_item
    )
    transaction_3 = create(
      :transaction,
      invoice: invoice_3
    )

    customer_2 = create(:customer)
    invoice_4 = create(
      :invoice,
      customer: customer_2,
      merchant: merchant_1
    )
    invoice_item_4 = create(
      :invoice_item,
      invoice: invoice_4,
      item: merchant_1_item
    )
    transaction_4 = create(
      :transaction,
      invoice: invoice_4
    )
    invoice_5 = create(
      :invoice,
      customer: customer_2,
      merchant: merchant_1
    )
    invoice_item_5 = create(
      :invoice_item,
      invoice: invoice_5,
      item: merchant_1_item
    )
    transaction_5 = create(
      :transaction,
      invoice: invoice_5,
      result: 'failed'
    )
    invoice_6 = create(
      :invoice,
      customer: customer_2,
      merchant: merchant_1
    )
    invoice_item_6 = create(
      :invoice_item,
      invoice: invoice_6,
      item: merchant_1_item
    )
    transaction_6 = create(
      :transaction,
      invoice: invoice_6
    )

    get "/api/v1/customers/#{customer_1.id}/favorite_merchant"

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(merchant_1.id)

    get "/api/v1/customers/#{customer_2.id}/favorite_merchant"

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(merchant_1.id)
  end
end
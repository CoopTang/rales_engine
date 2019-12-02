require 'rails_helper'

RSpec.describe 'Merchant Business Intelligence API:' do
  before :each do
    FactoryBot.rewind_sequences
  end

  describe 'most_revenue' do
    it 'can return a variable amount of top merchants' do
      merchant_1 = create(:merchant)
      merchant_item_1 = create(:item_with_transactions, merchant: merchant_1)
  
      merchant_2 = create(:merchant)
      merchant_item_2 = create(:item_with_transactions, merchant: merchant_2, unit_price: 30)
  
      merchant_3 = create(:merchant)
      merchant_item_3 = create(:item_with_transactions, merchant: merchant_3)

      get '/api/v1/merchants/most_revenue?quantity=3'

      merchants = JSON.parse(response.body)['data']
      
      expect(merchants.length).to eq(3)

      expect(merchants[0]['attributes']['id']).to eq(merchant_2.id)
      expect(merchants[0]['attributes']['name']).to eq(merchant_2.name)

      expect(merchants[1]['attributes']['id']).to eq(merchant_3.id)
      expect(merchants[1]['attributes']['name']).to eq(merchant_3.name)

      expect(merchants[2]['attributes']['id']).to eq(merchant_1.id)
      expect(merchants[2]['attributes']['name']).to eq(merchant_1.name)

      get '/api/v1/merchants/most_revenue?quantity=2'

      merchants = JSON.parse(response.body)['data']
      
      expect(merchants.length).to eq(2)

      expect(merchants[0]['attributes']['id']).to eq(merchant_2.id)
      expect(merchants[0]['attributes']['name']).to eq(merchant_2.name)

      expect(merchants[1]['attributes']['id']).to eq(merchant_3.id)
      expect(merchants[1]['attributes']['name']).to eq(merchant_3.name)
    end


  end
  
  xit 'revenue' do    
    merchant_1 = create(:merchant)
    merchant_1_item_1 = create(
      :item,
      name: "#{merchant_1.name}_item_1",
      description: "#{merchant_1.name}_item_description_1",
      merchant: merchant_1
    )
    merchant_1_invoice_1 = create(
      :invoice,
      merchant: merchant_1,
      created_at: "2012-03-26 14:53:59 UTC"
      )
    merchant_1_invoice_item_1 = create(
      :invoice_item,
      item: merchant_1_item_1,
      invoice: merchant_1_invoice_1,
      unit_price: merchant_1_item_1.unit_price
    )
    merchant_1_item_2 = create(
      :item,
      name: "#{merchant_1.name}_item_2",
      description: "#{merchant_1.name}_item_description_2",
      merchant: merchant_1
    )
    merchant_1_invoice_2 = create(
      :invoice,
      merchant: merchant_1,
      created_at: "2012-03-27 14:53:59 UTC"
    )
    merchant_1_invoice_item_2 = create(
      :invoice_item,
      item: merchant_1_item_2,
      invoice: merchant_1_invoice_2,
      unit_price: merchant_1_item_2.unit_price,
      quantity: 1000
    )
    merchant_1_item_3 = create(
      :item,
      name: "#{merchant_1.name}_item_3",
      description: "#{merchant_1.name}_item_description_3",
      merchant: merchant_1
    )
    merchant_1_invoice_3 = create(
      :invoice,
      merchant: merchant_1,
      created_at: "2012-03-28 14:53:59 UTC"
    )
    merchant_1_invoice_item_3 = create(
      :invoice_item,
      item: merchant_1_item_3,
      invoice: merchant_1_invoice_3,
      unit_price: merchant_1_item_3.unit_price,
      quantity: 100
    )

    merchant_2 = create(:merchant)
    merchant_2_item_1 = create(
      :item,
      name: "#{merchant_2.name}_item_1",
      description: "#{merchant_2.name}_item_description_1",
      merchant: merchant_2
    )
    merchant_2_invoice_1 = create(
      :invoice,
      merchant: merchant_2,
      created_at: "2012-03-26 14:53:59 UTC"
      )
    merchant_2_invoice_item_1 = create(
      :invoice_item,
      item: merchant_2_item_1,
      invoice: merchant_2_invoice_1,
      unit_price: merchant_2_item_1.unit_price
    )
    merchant_2_item_2 = create(
      :item,
      name: "#{merchant_2.name}_item_2",
      description: "#{merchant_2.name}_item_description_2",
      merchant: merchant_2
    )
    merchant_2_invoice_2 = create(
      :invoice,
      merchant: merchant_2,
      created_at: "2012-03-27 14:53:59 UTC"
    )
    merchant_2_invoice_item_2 = create(
      :invoice_item,
      item: merchant_2_item_2,
      invoice: merchant_2_invoice_2,
      unit_price: merchant_2_item_2.unit_price
    )
    merchant_2_item_3 = create(
      :item,
      name: "#{merchant_2.name}_item_3",
      description: "#{merchant_2.name}_item_description_3",
      merchant: merchant_2
    )
    merchant_2_invoice_3 = create(
      :invoice,
      merchant: merchant_2,
      created_at: "2012-03-28 14:53:59 UTC"
    )
    merchant_2_invoice_item_3 = create(
      :invoice_item,
      item: merchant_2_item_3,
      invoice: merchant_2_invoice_3,
      unit_price: merchant_2_item_3.unit_price,
      quantity: 1000
    )

    merchant_3 = create(:merchant)
    merchant_3_item_1 = create(
      :item,
      name: "#{merchant_3.name}_item_1",
      description: "#{merchant_3.name}_item_description_1",
      merchant: merchant_3
    )
    merchant_3_invoice_1 = create(
      :invoice,
      merchant: merchant_3,
      created_at: "2012-03-26 14:53:59 UTC"
      )
    merchant_3_invoice_item_1 = create(
      :invoice_item,
      item: merchant_3_item_1,
      invoice: merchant_3_invoice_1,
      unit_price: merchant_3_item_1.unit_price
    )
    merchant_3_item_2 = create(
      :item,
      name: "#{merchant_3.name}_item_2",
      description: "#{merchant_3.name}_item_description_2",
      merchant: merchant_3
    )
    merchant_3_invoice_2 = create(
      :invoice,
      merchant: merchant_3,
      created_at: "2012-03-27 14:53:59 UTC"
    )
    merchant_3_invoice_item_2 = create(
      :invoice_item,
      item: merchant_3_item_2,
      invoice: merchant_3_invoice_2,
      unit_price: merchant_3_item_2.unit_price,
      quantity: 100
    )
    merchant_3_item_3 = create(
      :item,
      name: "#{merchant_3.name}_item_3",
      description: "#{merchant_3.name}_item_description_3",
      merchant: merchant_3
    )
    merchant_3_invoice_3 = create(
      :invoice,
      merchant: merchant_3,
      created_at: "2012-03-28 14:53:59 UTC"
    )
    merchant_3_invoice_item_3 = create(
      :invoice_item,
      item: merchant_3_item_3,
      invoice: merchant_3_invoice_3,
      unit_price: merchant_3_item_3.unit_price
    )

    get "/api/v1/merchants/revenue?date=2012-03-26"

    merchants = JSON.parse(response.body)['data']
    
    expect(merchants.length).to eq(Merchant.all.length)

    expect(merchants[0]['attributes']['id']).to eq(merchant_3.id)
    expect(merchants[0]['attributes']['name']).to eq(merchant_3.name)

    expect(merchants[1]['attributes']['id']).to eq(merchant_2.id)
    expect(merchants[1]['attributes']['name']).to eq(merchant_2.name)

    expect(merchants[2]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[2]['attributes']['name']).to eq(merchant_1.name)

    get "/api/v1/merchants/revenue?date=2012-03-27"

    merchants = JSON.parse(response.body)['data']
    
    expect(merchants.length).to eq(Merchant.all.length)

    expect(merchants[0]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[0]['attributes']['name']).to eq(merchant_1.name)

    expect(merchants[1]['attributes']['id']).to eq(merchant_3.id)
    expect(merchants[1]['attributes']['name']).to eq(merchant_3.name)

    expect(merchants[2]['attributes']['id']).to eq(merchant_2.id)
    expect(merchants[2]['attributes']['name']).to eq(merchant_2.name)

    get "/api/v1/merchants/revenue?date=2012-03-28"

    merchants = JSON.parse(response.body)['data']
    
    expect(merchants.length).to eq(Merchant.all.length)

    expect(merchants[0]['attributes']['id']).to eq(merchant_2.id)
    expect(merchants[0]['attributes']['name']).to eq(merchant_2.name)

    expect(merchants[1]['attributes']['id']).to eq(merchant_1.id)
    expect(merchants[1]['attributes']['name']).to eq(merchant_1.name)

    expect(merchants[2]['attributes']['id']).to eq(merchant_3.id)
    expect(merchants[2]['attributes']['name']).to eq(merchant_3.name)
  end

  it 'favorite_customer' do
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
      invoice: invoice_1
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

    get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(customer_2.id)

    get "/api/v1/merchants/#{merchant_2.id}/favorite_customer"

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(customer_1.id)
  end
end
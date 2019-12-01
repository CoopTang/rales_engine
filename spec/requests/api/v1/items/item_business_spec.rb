require 'rails_helper'

RSpec.describe 'Item Business Intelligence API:' do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'most_revenue' do
    item_1 = create(:item_with_transactions)
    item_2 = create(:item_with_transactions)
    item_3 = create(:item_with_transactions, unit_price: 1000)
    item_4 = create(:item_with_transactions)
    item_5 = create(:item_with_transactions)

    get '/api/v1/items/most_revenue?quantity=1'

    items = JSON.parse(response.body)['data']

    expect(items.length).to eq(1)

    expect(items[0]['attributes']['id']).to eq(item_3.id)
    expect(items[0]['attributes']['name']).to eq(item_3.name)

    get '/api/v1/items/most_revenue?quantity=3'

    items = JSON.parse(response.body)['data']

    expect(items.length).to eq(3)

    expect(items[0]['attributes']['id']).to eq(item_3.id)
    expect(items[0]['attributes']['name']).to eq(item_3.name)

    expect(items[1]['attributes']['id']).to eq(item_5.id)
    expect(items[1]['attributes']['name']).to eq(item_5.name)

    expect(items[2]['attributes']['id']).to eq(item_4.id)
    expect(items[2]['attributes']['name']).to eq(item_4.name)
  end
  
  it 'best_day' do
    item_1 = create(:item)
    invoice_1 = create(
      :invoice,
      merchant: item_1.merchant,
      created_at: "2012-03-26 14:53:00 UTC"
    )
    invoice_2 = create(
      :invoice,
      merchant: item_1.merchant,
      created_at: "2012-03-27 14:53:59 UTC"
    )
    invoice_item_1 = create(
      :invoice_item,
      invoice: invoice_1,
      item: item_1,
      unit_price: item_1.unit_price,
      quantity: 5
    )
    invoice_item_2 = create(
      :invoice_item,
      invoice: invoice_2,
      item: item_1,
      unit_price: item_1.unit_price,
      quantity: 5
    )

    get "/api/v1/items/#{item_1.id}/best_day"

    date = JSON.parse(response.body)['data']

    expect(date['attributes']['best_day']).to eq('2012-03-27')
  end
end
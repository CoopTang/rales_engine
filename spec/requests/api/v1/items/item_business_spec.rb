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
  end
end
require 'rails_helper'

RSpec.describe 'Merchant Business Intelligence API:' do
  before :each do
    FactoryBot.rewind_sequences
  end

  describe 'most_revenue' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_item_1 = create(:item_with_transactions, merchant: @merchant_1)

      @merchant_2 = create(:merchant)
      @merchant_item_2 = create(:item_with_transactions, merchant: @merchant_2, unit_price: 30)

      @merchant_3 = create(:merchant)
      @merchant_item_3 = create(:item_with_transactions, merchant: @merchant_3)
    end
    
    it 'can return a variable amount of top merchants' do
      get '/api/v1/merchants/most_revenue?quantity=3'

      merchants = JSON.parse(response.body)['data']
      
      expect(merchants.length).to eq(3)

      expect(merchants[0]['attributes']['id']).to eq(@merchant_2.id)
      expect(merchants[0]['attributes']['name']).to eq(@merchant_2.name)

      expect(merchants[1]['attributes']['id']).to eq(@merchant_3.id)
      expect(merchants[1]['attributes']['name']).to eq(@merchant_3.name)

      expect(merchants[2]['attributes']['id']).to eq(@merchant_1.id)
      expect(merchants[2]['attributes']['name']).to eq(@merchant_1.name)

      get '/api/v1/merchants/most_revenue?quantity=2'

      merchants = JSON.parse(response.body)['data']
      
      expect(merchants.length).to eq(2)

      expect(merchants[0]['attributes']['id']).to eq(@merchant_2.id)
      expect(merchants[0]['attributes']['name']).to eq(@merchant_2.name)

      expect(merchants[1]['attributes']['id']).to eq(@merchant_3.id)
      expect(merchants[1]['attributes']['name']).to eq(@merchant_3.name)
    end


  end
  
  it 'revenue' do
  end
end
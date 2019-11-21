require 'rails_helper'

RSpec.describe "Merchants API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    create_list(:merchant, 2)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)

    expect(merchants["data"][0]["attributes"]["name"]).to eq("merchant_1")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("merchant_2")
  end

  it 'Show' do
    create_list(:merchant, 2)

    get "/api/v1/merchants/#{Merchant.last.id}"

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["name"]).to eq("merchant_2")
  end
  
  describe 'Find' do
    it 'by id' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find?id=#{Merchant.first.id}"
      
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["attributes"]["name"]).to eq("merchant_1")
    end

    it 'by name' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find?name=#{Merchant.last.name}"
      
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["attributes"]["name"]).to eq("merchant_2")
    end

    xit 'by created_at' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find?created_at=#{Merchant.first.created_at}"
      
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["attributes"]["name"]).to eq("merchant_1")
    end

    xit 'by created_at' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find?updated_at=#{Merchant.last.updated_at}"
      
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["attributes"]["name"]).to eq("merchant_2")
    end

    it 'by multiple queries' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find?id=#{Merchant.first.id}&name=#{Merchant.first.name}"
      
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["attributes"]["name"]).to eq("merchant_1")
    end
  end

  describe 'Find_all' do
    it 'by id' do
      create_list(:merchant, 2)
      
      get "/api/v1/merchants/find_all?id=#{Merchant.first.id}"
      
      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(1)
      
      expect(merchants["data"][0]["attributes"]["name"]).to eq("merchant_1")
    end
    
    it 'by name' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, name: "merchant_1")
      
      get "/api/v1/merchants/find_all?name=#{Merchant.first.name}"
      
      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(2)
      
      expect(merchants["data"][0]["attributes"]["name"]).to eq("merchant_1")
      expect(merchants["data"][1]["attributes"]["name"]).to eq("merchant_1")
    end
    
    it 'by multiple queries' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, name: "merchant_1")
      
      get "/api/v1/merchants/find_all?id=#{Merchant.first.id}&name=#{Merchant.first.name}"

      merchants = JSON.parse(response.body)
      
      expect(merchants["data"].count).to eq(1)
      
      expect(merchants["data"][0]["attributes"]["name"]).to eq("merchant_1")
    end
  end
end
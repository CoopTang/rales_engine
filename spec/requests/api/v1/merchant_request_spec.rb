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
  end
end
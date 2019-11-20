require 'rails_helper'

RSpec.describe "Merchants API:" do
  it 'Index' do
    create_list(:merchant, 2)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)

    expect(merchants["data"][0]["attributes"]["name"]).to eq("merchant_1")
    expect(merchants["data"][1]["attributes"]["name"]).to eq("merchant_2")
  end
end
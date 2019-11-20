require 'rails_helper'

RSpec.describe "Merchants API:" do
  it 'Index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end
end
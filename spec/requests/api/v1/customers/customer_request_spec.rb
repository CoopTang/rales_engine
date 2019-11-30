require 'rails_helper'

RSpec.describe "Customer API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)

    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
    expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
    expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')

    expect(customers["data"][1]["attributes"]["id"]).to eq(customer_2.id)
    expect(customers["data"][1]["attributes"]["first_name"]).to eq('first_name_2')
    expect(customers["data"][1]["attributes"]["last_name"]).to eq('last_name_2')
  end

  it 'Show' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/#{customer_2.id}"

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["id"]).to eq(customer_2.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_2')
    expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_2')
  end
  
  describe 'Find' do
    it 'by id' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      
      get "/api/v1/customers/find?id=#{customer_1.id}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_1')
    end

    it 'by first_name' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      
      get "/api/v1/customers/find?first_name=#{customer_1.first_name}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_2.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_2')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_2')
    end

    it 'by last_name' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)

      get "/api/v1/customers/find?last_name=#{customer_1.last_name}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_1')
    end

    it 'by created_at' do
      customer_1 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      customer_2 = create(
        :customer,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      
      get "/api/v1/customers/find?created_at=#{customer_1.created_at}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_1')
    end

    it 'by updated_at' do
      customer_1 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      customer_2 = create(
        :customer,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      get "/api/v1/customers/find?updated_at=#{customer_2.updated_at}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_2.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_2')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_2')
    end

    it 'by multiple queries' do
      customer_1 = create(:customer)
      customer_2 = create(
        :customer,
        last_name: customer_1.last_name
      )
      
      get "/api/v1/customers/find?last_name=#{customer_1.last_name}&id=#{customer_1.id}"
      
      customer = JSON.parse(response.body)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_1')
    end
  end

  describe 'Find_all' do
    it 'by id' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      
      get "/api/v1/customers/find_all?id=#{customer_1.id}"
      
      customers = JSON.parse(response.body)

      expect(customers["data"].count).to eq(1)
      
      expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
      expect(customer["data"]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customer["data"]["attributes"]["last_name"]).to eq('last_name_1')
    end

    it 'by first_name' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(
        :customer,
        first_name: customer_1.first_name
      )
      
      get "/api/v1/customers/find_all?first_name=#{customer_1.id}"
      
      customers = JSON.parse(response.body)

      expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
      expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')

      expect(customers["data"][1]["attributes"]["id"]).to eq(customer_3.id)
      expect(customers["data"][1]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][1]["attributes"]["last_name"]).to eq('last_name_3')
    end

    it 'by last_name' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(
        :customer,
        last_name: customer_1.last_name
      )
      
      get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"
      
      customers = JSON.parse(response.body)

      expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
      expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')

      expect(customers["data"][1]["attributes"]["id"]).to eq(customer_3.id)
      expect(customers["data"][1]["attributes"]["first_name"]).to eq('first_name_3')
      expect(customers["data"][1]["attributes"]["last_name"]).to eq('last_name_1')
    end
    
    it 'by created_at' do
      customer_1 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      customer_2 = create(
        :customer,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      customer_3 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC"
      )
    
      get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

      customers = JSON.parse(response.body)
      
      expect(customers["data"].count).to eq(2)
      
      expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
      expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')

      expect(customers["data"][1]["attributes"]["id"]).to eq(customer_3.id)
      expect(customers["data"][1]["attributes"]["first_name"]).to eq('first_name_3')
      expect(customers["data"][1]["attributes"]["last_name"]).to eq('last_name_3')
    end

    it 'by updated_at' do
      customer_1 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      customer_2 = create(
        :customer,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      customer_3 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"
      
      customers = JSON.parse(response.body)

      expect(customers["data"].count).to eq(2)
      
      expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
      expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')

      expect(customers["data"][1]["attributes"]["id"]).to eq(customer_3.id)
      expect(customers["data"][1]["attributes"]["first_name"]).to eq('first_name_3')
      expect(customers["data"][1]["attributes"]["last_name"]).to eq('last_name_3')
    end
    
    it 'by multiple queries' do
      customer_1 = create(
        :customer,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      customer_2 = create(
        :customer,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      customer_3 = create(
        :customer,
        last_name: customer_1.last_name,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}&updated_at=#{customer_1.updated_at}"
      
      customers = JSON.parse(response.body)

      expect(customers["data"].count).to eq(1)
      
      expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
      expect(customers["data"][0]["attributes"]["first_name"]).to eq('first_name_1')
      expect(customers["data"][0]["attributes"]["last_name"]).to eq('last_name_1')
    end
  end

  it 'Random' do
    create_list(:customer, 5)

    get '/api/v1/customers/random'

    customer = JSON.parse(response.body)

    result = Customer.find_by(id: customer['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end

  it 'invoice' do
    customer_1 = create(:customer_with_invoices)

    invoice_1 = Invoice.first

    get "/api/v1/customers/#{customer_1.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(3)

    expect(invoices['data'][0]['attributes']['id']).to eq(customer_1.invoice.id)
    expect(invoices['data'][0]['attributes']['customer_id']).to eq(customer_1.id)
    expect(invoices['data'][0]['type']).to eq("invoice")
  end

  it 'transaction' do
    customer_1 = create(:customer_with_invoices)

    transaction_1 = Transaction.first

    get "/api/v1/customers/#{customer_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(3)

    expect(transactions['data'][0]['attributes']['id']).to eq(customer_1.transaction.id)
    expect(transactions['data'][0]['attributes']['credit_card_number']).to eq(customer_1.invoice.customer.id)
    expect(transactions['data'][0]['type']).to eq("transaction")
  end
end
require 'rails_helper'

RSpec.describe "Invoice API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    customer_1 = invoice_1.customer
    customer_2 = invoice_2.customer

    merchant_1 = invoice_1.merchant
    merchant_2 = invoice_2.merchant

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)

    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
    expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

    expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_2.id)
    expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_2.id)
    expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_2.status)
  end

  it 'Show' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    customer_1 = invoice_1.customer
    customer_2 = invoice_2.customer

    merchant_1 = invoice_1.merchant
    merchant_2 = invoice_2.merchant

    get "/api/v1/invoices/#{invoice_2.id}"

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_2.id)
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_2.id)
    expect(invoice["data"]["attributes"]["status"]).to eq(invoice_2.status)
  end
  
  describe 'Find' do
    it 'by id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find?id=#{invoice_1.id}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_1.status)
    end

    it 'by customer_id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find?customer_id=#{customer_2.id}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_2.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_2.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_2.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_2.status)
    end

    it 'by merchant_id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant

      get "/api/v1/invoices/find?merchant_id=#{merchant_1.id}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_1.status)
    end

    it 'by status' do
      invoice_1 = create(:invoice)
      invoice_2 = create(
        :invoice,
        status: 'cancelled'
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant

      get "/api/v1/invoices/find?status=#{merchant_2.status}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_2.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_2.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_2.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_2.status)
    end

    it 'by created_at' do
      invoice_1 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      invoice_2 = create(
        :invoice,
        created_at: "2012-03-27 14:53:00 UTC"
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_1.status)
    end

    it 'by updated_at' do
      invoice_1 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      invoice_2 = create(
        :invoice,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find?updated_at=#{invoice_2.updated_at}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_2.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_2.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_2.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_2.status)
    end

    it 'by multiple queries' do
      invoice_1 = create(:invoice)
      invoice_2 = create(
        :invoice,
        merchant: invoice_1.merchant
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find?merchant_id=#{merchant_1.id}&id=#{invoice_2.id}"
      
      invoice = JSON.parse(response.body)
      
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_2.id)
      expect(invoice["data"]["attributes"]["customer_id"]).to eq(customer_2.id)
      expect(invoice["data"]["attributes"]["merchant_id"]).to eq(merchant_2.id)
      expect(invoice["data"]["attributes"]["status"]).to eq(invoice_2.status)
    end
  end

  describe 'Find_all' do
    it 'by id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      
      get "/api/v1/invoices/find_all?id=#{invoice_1.id}"
      
      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(1)
      
      expect(invoice["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoice["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoice["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoice["data"][0]["attributes"]["status"]).to eq(invoice_1.status)
    end

    it 'by customer_id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_3 = create(
        :invoice,
        customer: invoice_1.customer
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer
      customer_3 = invoice_3.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      merchant_3 = invoice_3.merchant
      
      get "/api/v1/invoices/find_all?customer_id=#{customer_1.id}"
      
      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(2)

      expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

      expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_3.id)
      expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_3.id)
      expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_3.status)
    end

    it 'by merchant_id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_3 = create(
        :invoice,
        merchant: invoice_1.merchant
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer
      customer_3 = invoice_3.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      merchant_3 = invoice_3.merchant
      
      get "/api/v1/invoices/find_all?merchant_id=#{merchant_1.id}"
      
      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(2)

      expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

      expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_3.id)
      expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_3.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_3.status)
    end
    
    it 'by created_at' do
      invoice_1 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      invoice_2 = create(
        :invoice,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      invoice_3 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC"
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer
      customer_3 = invoice_3.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      merchant_3 = invoice_3.merchant
    
      get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

      invoices = JSON.parse(response.body)
      
      expect(invoices["data"].count).to eq(2)
      
      expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

      expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_3.id)
      expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_3.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_3.id)
      expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_3.status)
    end

    it 'by updated_at' do
      invoice_1 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      invoice_2 = create(
        :invoice,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      invoice_3 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer
      customer_3 = invoice_3.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      merchant_3 = invoice_3.merchant
      
      get "/api/v1/invoices/find_all?updated_at=#{invoice_1.updated_at}"
      
      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(2)
      
      expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

      expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_3.id)
      expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_3.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_3.id)
      expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_3.status)
    end
    
    it 'by multiple queries' do
      invoice_1 = create(
        :invoice,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      invoice_2 = create(
        :invoice,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      invoice_3 = create(
        :invoice,
        merchant: invoice_1.merchant,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )

      customer_1 = invoice_1.customer
      customer_2 = invoice_2.customer
      customer_3 = invoice_3.customer

      merchant_1 = invoice_1.merchant
      merchant_2 = invoice_2.merchant
      merchant_3 = invoice_3.merchant
      
      get "/api/v1/invoices/find_all?merchant_id=#{merchant_1.id}&updated_at=#{invoice_1.updated_at}"
      
      invoices = JSON.parse(response.body)

      expect(invoices["data"].count).to eq(2)
      
      expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
      expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(customer_1.id)
      expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

      expect(invoices["data"][1]["attributes"]["id"]).to eq(invoice_3.id)
      expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(customer_3.id)
      expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(merchant_1.id)
      expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_3.status)
    end
  end

  it 'Random' do
    create_list(:invoice, 5)

    get '/api/v1/invoices/random'

    invoice = JSON.parse(response.body)

    result = Invoice.find_by(id: invoice['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end

  it 'items' do
    invoice_1 = create(:invoice_with_items)

    merchant_1 = invoice_1.merchant

    get "/api/v1/invoices/#{invoice_1.id}/items"

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)

    items.each.with_index do |item, i|
      expect(items['data'][i]['attributes']['id']).to eq(item.id)
      expect(items['data'][i]['attributes']['merchant_id']).to eq(merchant_1.id)
      expect(items['data'][i]['type']).to eq("item")
    end
  end

  it 'transactions' do
    invoice_1 = create(:invoice_with_transactions)

    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(9)

    transactions.each.with_index do |transaction, i|
      expect(transactions['data'][i]['attributes']['id']).to eq(transaction.id)
      expect(transactions['data'][i]['attributes']['invoice_id']).to eq(invoice_1.id)
      expect(transactions['data'][i]['type']).to eq("transaction")
    end
  end

  it 'invoice_items' do
    invoice_1 = create(:invoice_with_invoice_items)

    get "/api/v1/invoices/#{invoice_1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].count).to eq(3)

    invoice_items.each.with_index do |invoice_item, i|
      expect(invoice_items['data'][i]['attributes']['id']).to eq(invoice_item.id)
      expect(invoice_items['data'][i]['attributes']['invoice_id']).to eq(invoice_1.id)
      expect(invoice_items['data'][i]['type']).to eq("invoice_item")
    end
  end

  it 'customer' do
    invoice_1 = create(:invoice)

    customer_1 = invoice_1.customer

    get "/api/v1/invoices/#{invoice_1.id}/customer"

    customer = JSON.parse(response.body)

    expect(customer['data']['attributes']['id']).to eq(customer.id)
    expect(customer['data']['attributes']['first_name']).to eq(customer.first_name)
    expect(customer['data']['attributes']['last_name']).to eq(customer.last_name)
    expect(customer['data']['type']).to eq("customer")
  end

  it 'merchant' do
    invoice_1 = create(:invoice)

    merchant_1 = invoice_1.merchant

    get "/api/v1/invoices/#{invoice_1.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(merchant.id)
    expect(merchant['data']['attributes']['name']).to eq(merchant.name)
    expect(merchant['data']['type']).to eq("merchant")
  end
end
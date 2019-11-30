require 'rails_helper'

RSpec.describe "Transaction API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    invoice_1 = Invoice.first
    invoice_2 = Invoice.last

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)

    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
    expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
    expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
    expect(transactions["data"][0]["attributes"]["result"]).to eq('success')

    expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_2.id)
    expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_2.id)
    expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_2')
    expect(transactions["data"][1]["attributes"]["result"]).to eq('success')
  end

  it 'Show' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    invoice_1 = Invoice.first
    invoice_2 = Invoice.last

    get "/api/v1/transactions/#{transaction_2.id}"

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["attributes"]["id"]).to eq(transaction_2.id)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_2')
    expect(transaction["data"]["attributes"]["result"]).to eq('success')
  end
  
  describe 'Find' do
    it 'by id' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?id=#{transaction_1.id}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end

    it 'by invoice_id' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?invoice_id=#{invoice_2.id}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_2.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_2')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end

    it 'by credit_card_number' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?credit_card_number=#{transaction_1.credit_card_number}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end

    it 'by result' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction, result: 'failure')

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?result=#{transaction_2.result}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_2.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_2')
      expect(transaction["data"]["attributes"]["result"]).to eq('failure')
    end

    it 'by created_at' do
      transaction_1 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      transaction_2 = create(
        :transaction,
        created_at: "2012-03-27 14:53:00 UTC"
      )

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end

    it 'by updated_at' do
      transaction_1 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      transaction_2 = create(
        :transaction,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?updated_at=#{transaction_2.updated_at}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_2.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_2')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end

    it 'by multiple queries' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find?result=success&id=#{transaction_1.id}"
      
      transaction = JSON.parse(response.body)
      
      expect(transaction["data"]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transaction["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transaction["data"]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transaction["data"]["attributes"]["result"]).to eq('success')
    end
  end

  describe 'Find_all' do
    it 'by id' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/transactions/find_all?id=#{transaction_1.id}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"].count).to eq(1)
      
      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
    end

    it 'by invoice_id' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)
      transaction_3 = create(
        :transaction,
        invoice: transaction_1.invoice
      )
      
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/transactions/find_all?invoice_id=#{invoice_1.id}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
      
      expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_3.id)
      expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_3')
      expect(transactions["data"][1]["attributes"]["result"]).to eq('success')
    end

    it 'by credit_card_number' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)
      transaction_3 = create(
        :transaction,
        credit_card_number: transaction_1.credit_card_number
      )
      
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
      
      expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_3.id)
      expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][1]["attributes"]["result"]).to eq('success')
    end

    it 'by result' do
      transaction_1 = create(
        :transaction,
        result: 'failure'
      )
      transaction_2 = create(:transaction)
      transaction_3 = create(
        :transaction,
        result: 'failure'
      )
      
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/transactions/find_all?result=#{transaction_1.result}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('failure')
      
      expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_3.id)
      expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_3')
      expect(transactions["data"][1]["attributes"]["result"]).to eq('failure')
    end
    
    it 'by created_at' do
      transaction_1 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      transaction_2 = create(
        :transaction,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      transaction_3 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

      transactions = JSON.parse(response.body)
      
      expect(transactions["data"].count).to eq(2)
      
      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
      
      expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_3.id)
      expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_3')
      expect(transactions["data"][1]["attributes"]["result"]).to eq('success')
    end

    it 'by updated_at' do
      transaction_1 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      transaction_2 = create(
        :transaction,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      transaction_3 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )

      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/transactions/find_all?updated_at=#{transaction_1.updated_at}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"].count).to eq(2)
      
      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
      
      expect(transactions["data"][1]["attributes"]["id"]).to eq(transaction_3.id)
      expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq('credit_card_number_3')
      expect(transactions["data"][1]["attributes"]["result"]).to eq('success')
    end
    
    it 'by multiple queries' do
      transaction_1 = create(
        :transaction,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      transaction_2 = create(
        :transaction,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      transaction_3 = create(
        :transaction,
        result: 'failure',
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )

      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/transactions/find_all?result=success&updated_at=#{transaction_1.updated_at}"
      
      transactions = JSON.parse(response.body)

      expect(transactions["data"].count).to eq(1)
      
      expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
      expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq('credit_card_number_1')
      expect(transactions["data"][0]["attributes"]["result"]).to eq('success')
    end
  end

  it 'Random' do
    create_list(:transaction, 5)

    get '/api/v1/transactions/random'

    transaction = JSON.parse(response.body)

    result = Transaction.find_by(id: transaction['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end

  it 'invoice' do
    transaction_1 = create(:transaction)

    get "/api/v1/transactions/#{transaction_1.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(invoice['data']['attributes']['id']).to eq(transaction_1.invoice.id)
    expect(invoice['data']['attributes']['customer_id']).to eq(transaction_1.invoice.customer.id)
    expect(invoice['data']['attributes']['merchant_id']).to eq(transaction_1.invoice.merchant.id)
    expect(invoice['data']['type']).to eq("invoice")
  end
end
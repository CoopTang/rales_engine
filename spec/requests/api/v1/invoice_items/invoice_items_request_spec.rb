require 'rails_helper'

RSpec.describe "InvoiceItem API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)
    item_1    = Item.first
    item_2    = Item.last
    invoice_1 = Invoice.first
    invoice_2 = Invoice.last

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)

    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

    expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_2.id)
    expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_2.id)
    expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_2.id)
    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(2)
    expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.02')
  end

  it 'Show' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)
    item_1    = Item.first
    item_2    = Item.last
    invoice_1 = Invoice.first
    invoice_2 = Invoice.last

    get "/api/v1/invoice_items/#{InvoiceItem.last.id}"

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_2.id)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_2.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(2)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
  end
  
  describe 'Find' do
    it 'by id' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?id=#{InvoiceItem.first.id}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(1)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by item_id' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?item_id=#{Item.last.id}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_2.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_2.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(2)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
    end

    it 'by invoice_id' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?invoice_id=#{Invoice.first.id}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(1)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by quantity' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?quantity=#{invoice_item_2.quantity}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_2.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_2.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(2)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
    end

    it 'by unit_price' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(1)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end
    
    it 'by created_at' do
      invoice_item_1 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      invoice_item_2 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      
      get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(1)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by updated_at' do
      invoice_item_1 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      invoice_item_2 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?updated_at=#{invoice_item_2.updated_at}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_2.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_2.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(2)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
    end

    it 'by multiple queries' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}&unit_price=#{invoice_item_1.unit_price}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq(1)
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end
  end

  describe 'Find_all' do
    it 'by id' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find_all?id=#{InvoiceItem.first.id}"
      
      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(1)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by item_id' do
      invoice_item_1 = create(
        :invoice_item,
      )
      invoice_item_2 = create(
        :invoice_item,
      )
      invoice_item_3 = create(
        :invoice_item,
        item: invoice_item_1.item
      )
      item_1    = Item.first
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(3)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.03')
    end

    it 'by invoice_id' do
      invoice_item_1 = create(
        :invoice_item,
      )
      invoice_item_2 = create(
        :invoice_item,
      )
      invoice_item_3 = create(
        :invoice_item,
        invoice: invoice_item_1.invoice
      )
      item_1    = Item.first
      item_3    = Item.last
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_3.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(3)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.03')
    end

    it 'by unit_price' do
      invoice_item_1 = create(
        :invoice_item,
      )
      invoice_item_2 = create(
        :invoice_item,
      )
      invoice_item_3 = create(
        :invoice_item,
        unit_price: invoice_item_1.unit_price
      )
      item_1    = Item.first
      item_3    = Item.last
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_3.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(3)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by quantity' do
      invoice_item_1 = create(
        :invoice_item,
      )
      invoice_item_2 = create(
        :invoice_item,
      )
      invoice_item_3 = create(
        :invoice_item,
        quantity: invoice_item_1.quantity
      )
      item_1    = Item.first
      item_3    = Item.last
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_3.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.03')
    end

    it 'by created_at' do
      invoice_item_1 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      invoice_item_2 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      invoice_item_3 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:59 UTC",
      )
      item_1    = Item.first
      item_3    = Item.last
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
    
      get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_3.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(3)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.03')
    end

    it 'by updated_at' do
      invoice_item_1 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      invoice_item_2 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      invoice_item_3 = create(
        :invoice_item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      item_1    = Item.first
      item_3    = Item.last
      invoice_1 = Invoice.first
      invoice_3 = Invoice.last
      
      get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_1.updated_at}"
      
      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_3.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_3.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_3.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(3)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.03')
    end
    
    it 'by multiple queries' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item, quantity: 1, unit_price: 1)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find_all?quantity=1&unit_price=1"

      invoice_items = JSON.parse(response.body)
      
      expect(invoice_items["data"].count).to eq(2)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(item_1.id)
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(invoice_1.id)
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_2.id)
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(item_2.id)
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(invoice_2.id)
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(1)
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.01')
    end
  end

  it 'Random' do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items/random'

    invoice_item = JSON.parse(response.body)

    result = InvoiceItem.find_by(id: invoice_item['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end

  it 'invoice' do
    invoice_item_1 = create(:invoice_item)
    invoice_1 = Invoice.first

    get "/api/v1/invoice_items/#{invoice_item_1.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["data"]["type"]).to eq('invoice')
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(invoice_1.customer.id)
  end
  
  it 'item' do
    invoice_item_1 = create(:invoice_item)
    item_1    = Item.first
    
    get "/api/v1/invoice_items/#{invoice_item_1.id}/item"
    
    item = JSON.parse(response.body)
    
    expect(item["data"]["attributes"]["id"]).to eq(item_1.id)
    expect(item["data"]["type"]).to eq('item')
    expect(item["data"]["attributes"]["name"]).to eq(item_1.name)
  end
end
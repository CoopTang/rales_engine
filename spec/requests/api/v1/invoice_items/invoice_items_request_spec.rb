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

    expect(invoice_items["data"][0]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_1.id}")
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq("1")
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

    expect(invoice_items["data"][1]["attributes"]["id"]).to eq("#{invoice_item_2.id}")
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_2.id}")
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_2.id}")
    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq("2")
    expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.02')
  end

  it 'Show' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)
    item_1    = Item.first
    item_2    = Item.last
    invoice_1 = Invoice.first
    invoice_2 = Invoice.last

    get "/api/v1/invoice_items/#{Item.last.id}"

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_2.id}")
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_2.id}")
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_2.id}")
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq("2")
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
      
      get "/api/v1/invoice_items/find?id=#{Item.first.id}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq("1")
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.01')
    end

    it 'by name' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?name=#{Item.last.name}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_2.id}")
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_2.id}")
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_2.id}")
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq("2")
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
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
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq("1")
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
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_2.id}")
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_2.id}")
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_2.id}")
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq("2")
      expect(invoice_item["data"]["attributes"]["unit_price"]).to eq('0.02')
    end

    it 'by multiple queries' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      item_1    = Item.first
      item_2    = Item.last
      invoice_1 = Invoice.first
      invoice_2 = Invoice.last
      
      get "/api/v1/invoice_items/find?id=#{Item.first.id}&name=#{Item.first.name}"
      
      invoice_item = JSON.parse(response.body)
      
      expect(invoice_item["data"]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_item["data"]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_item["data"]["attributes"]["quantity"]).to eq("1")
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
      
      get "/api/v1/invoice_items/find_all?id=#{Item.first.id}"
      
      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(1)
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq("1")
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')
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
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq("1")
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq("#{invoice_item_3.id}")
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq("#{item_3.id}")
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq("#{invoice_3.id}")
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq("3")
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
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq("1")
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq("#{invoice_item_3.id}")
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq("#{item_3.id}")
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq("#{invoice_3.id}")
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq("3")
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
      
      expect(invoice_items["data"][0]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq("#{item_1.id}")
      expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq("#{invoice_1.id}")
      expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq("1")
      expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq('0.01')

      expect(invoice_items["data"][1]["attributes"]["id"]).to eq("#{invoice_item_1.id}")
      expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq("#{item_2.id}")
      expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq("#{invoice_2.id}")
      expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq("2")
      expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq('0.02')
    end
  end

  it 'Random' do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items/random'

    invoice_item = JSON.parse(response.body)

    result = Item.find_by(id: invoice_item['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end

  it 'invoice' do
  end

  it 'item' do
  end
end
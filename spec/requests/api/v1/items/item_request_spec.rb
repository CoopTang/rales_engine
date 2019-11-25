require 'rails_helper'

RSpec.describe "Item API:" do
  before :each do
    FactoryBot.rewind_sequences
  end

  it 'Index' do
    create_list(:item, 2)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)

    expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
    expect(items["data"][1]["attributes"]["name"]).to eq("item_2")
  end

  it 'Show' do
    create_list(:item, 2)

    get "/api/v1/items/#{Item.last.id}"

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["name"]).to eq("item_2")
  end
  
  describe 'Find' do
    it 'by id' do
      create_list(:item, 2)
      
      get "/api/v1/items/find?id=#{Item.first.id}"
      
      item = JSON.parse(response.body)
      
      expect(item["data"]["attributes"]["name"]).to eq("item_1")
    end

    it 'by name' do
      create_list(:item, 2)
      
      get "/api/v1/items/find?name=#{Item.last.name}"
      
      item = JSON.parse(response.body)
      
      expect(item["data"]["attributes"]["name"]).to eq("item_2")
    end

    it 'by created_at' do
      item_1 = create(
        :item,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      item_2 = create(
        :item,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      
      
      get "/api/v1/items/find?created_at=#{item_1.created_at}"
      
      item = JSON.parse(response.body)
      
      expect(item["data"]["attributes"]["name"]).to eq("item_1")
    end

    it 'by updated_at' do
      item_1 = create(
        :item,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      item_2 = create(
        :item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      get "/api/v1/items/find?updated_at=#{item_2.updated_at}"
      
      item = JSON.parse(response.body)
      
      expect(item["data"]["attributes"]["name"]).to eq("item_2")
    end

    it 'by multiple queries' do
      create_list(:item, 2)
      
      get "/api/v1/items/find?id=#{Item.first.id}&name=#{Item.first.name}"
      
      item = JSON.parse(response.body)
      
      expect(item["data"]["attributes"]["name"]).to eq("item_1")
    end
  end

  describe 'Find_all' do
    it 'by id' do
      create_list(:item, 2)
      
      get "/api/v1/items/find_all?id=#{Item.first.id}"
      
      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(1)
      
      expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
    end
    
    it 'by name' do
      item_1 = create(:item)
      item_2 = create(:item, name: "item_1")
      
      get "/api/v1/items/find_all?name=#{Item.first.name}"
      
      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      
      expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
      expect(items["data"][1]["attributes"]["name"]).to eq("item_1")
    end

    it 'by created_at' do
      item_1 = create(
        :item,
        created_at: "2012-03-27 14:53:59 UTC"
      )
      item_2 = create(
        :item,
        created_at: "2012-03-27 14:53:00 UTC"
      )
      item_3 = create(
        :item,
        created_at: "2012-03-27 14:53:59 UTC",
      )
    
      get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

      items = JSON.parse(response.body)
      
      expect(items["data"].count).to eq(2)
      
      expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
      expect(items["data"][1]["attributes"]["name"]).to eq("item_3")
    end

    it 'by updated_at' do
      item_1 = create(
        :item,
        created_at: "2012-03-27 14:53:59 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      item_2 = create(
        :item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:00 UTC"
      )
      item_3 = create(
        :item,
        created_at: "2012-03-27 14:53:00 UTC",
        updated_at: "2012-03-27 15:53:59 UTC"
      )
      
      get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"
      
      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      
      expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
      expect(items["data"][1]["attributes"]["name"]).to eq("item_3")
    end
    
    it 'by multiple queries' do
      item_1 = create(:item)
      item_2 = create(:item, name: "item_1")
      
      get "/api/v1/items/find_all?id=#{Item.first.id}&name=#{Item.first.name}"

      items = JSON.parse(response.body)
      
      expect(items["data"].count).to eq(1)
      
      expect(items["data"][0]["attributes"]["name"]).to eq("item_1")
    end
  end

  it 'Random' do
    create_list(:item, 5)

    get '/api/v1/items/random'

    item = JSON.parse(response.body)

    result = Item.find_by(id: item['data']['attributes']['id'])

    expect(result).to_not eq(nil)
  end
end
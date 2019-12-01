require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'methods' do
    before :each do
      FactoryBot.rewind_sequences
    end

    it 'most_revenue' do
      item_1 = create(:item_with_transactions)
      item_2 = create(:item_with_transactions)
      item_3 = create(:item_with_transactions, unit_price: 1000)
      item_4 = create(:item_with_transactions)
      item_5 = create(:item_with_transactions)

      result = Item.most_revenue(1)
      expect(result).to eq([item_3])

      result = Item.most_revenue(3)
      expect(result).to eq([item_3, item_5, item_4])
    end

    it '#best_day' do
      item_1 = create(:item)
      invoice_1 = create(:invoice, merchant: item_1.merchant)
      invoice_item_1 = create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        unit_price: item_1.unit_price,
        quantity: 4
      )
      invoice_item_2 = create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        unit_price: item_1.unit_price,
        quantity: 5,
        created_at: "2012-03-27 14:53:00 UTC"
        
      )
      invoice_item_3 = create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        unit_price: item_1.unit_price,
        quantity: 5,
        created_at: "2012-03-26 14:53:59 UTC"
      )

      result = item_1.best_day

      expect(result).to eq([invoice_item_3])
    end
  end
end

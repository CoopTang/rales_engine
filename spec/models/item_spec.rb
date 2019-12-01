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
  end
end

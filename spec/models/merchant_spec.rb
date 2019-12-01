require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    before :each do
      FactoryBot.rewind_sequences
    end

    describe 'total_revenue' do
      before :each do
        @merchant_1 = create(:merchant)
        @merchant_item_1 = create(:item_with_transactions, merchant: @merchant_1)
  
        @merchant_2 = create(:merchant)
        @merchant_item_2 = create(:item_with_transactions, merchant: @merchant_2, unit_price: 30)
  
        @merchant_3 = create(:merchant)
        @merchant_item_3 = create(:item_with_transactions, merchant: @merchant_3)
      end

      it 'can get a variable number of top merchants' do
        result = Merchant.total_revenue(3)

        expect(result).to eq([@merchant_2, @merchant_3, @merchant_1])

        result = Merchant.total_revenue(2)

        expect(result).to eq([@merchant_2, @merchant_3])
      end
    end
  end
end

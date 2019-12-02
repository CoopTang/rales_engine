require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
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
        result = Merchant.total_revenue(quantity: 3)

        expect(result).to eq([@merchant_2, @merchant_3, @merchant_1])

        result = Merchant.total_revenue(quantity: 2)

        expect(result).to eq([@merchant_2, @merchant_3])
      end
    end

    it '#favorite_customer' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      merchant_1_item = create(:item, merchant: merchant_1)
      merchant_2_item = create(:item, merchant: merchant_2)

      customer_1 = create(:customer)
      invoice_1 = create(
        :invoice,
        customer: customer_1,
        merchant: merchant_2
      )
      invoice_item_1 = create(
        :invoice_item,
        invoice: invoice_1,
        item: merchant_2_item
      )
      transaction_1 = create(
        :transaction,
        invoice: invoice_1
      )
      invoice_2 = create(
        :invoice,
        customer: customer_1,
        merchant: merchant_2
      )
      invoice_item_2 = create(
        :invoice_item,
        invoice: invoice_2,
        item: merchant_2_item
      )
      transaction_2 = create(
        :transaction,
        invoice: invoice_2,
        result: 'failed'
      )
      invoice_3 = create(
        :invoice,
        customer: customer_1,
        merchant: merchant_1
      )
      invoice_item_3 = create(
        :invoice_item,
        invoice: invoice_3,
        item: merchant_1_item
      )
      transaction_3 = create(
        :transaction,
        invoice: invoice_3
      )

      customer_2 = create(:customer)
      invoice_4 = create(
        :invoice,
        customer: customer_2,
        merchant: merchant_1
      )
      invoice_item_4 = create(
        :invoice_item,
        invoice: invoice_4,
        item: merchant_1_item
      )
      transaction_4 = create(
        :transaction,
        invoice: invoice_4
      )
      invoice_5 = create(
        :invoice,
        customer: customer_2,
        merchant: merchant_1
      )
      invoice_item_5 = create(
        :invoice_item,
        invoice: invoice_5,
        item: merchant_1_item
      )
      transaction_5 = create(
        :transaction,
        invoice: invoice_5,
        result: 'failed'
      )
      invoice_6 = create(
        :invoice,
        customer: customer_2,
        merchant: merchant_1
      )
      invoice_item_6 = create(
        :invoice_item,
        invoice: invoice_6,
        item: merchant_1_item
      )
      transaction_6 = create(
        :transaction,
        invoice: invoice_6
      )
      
      result_1 = merchant_1.favorite_customer
      result_2 = merchant_2.favorite_customer
      
      expect(result_1).to eq(customer_2)
      expect(result_2).to eq(customer_1)
    end
  end
end

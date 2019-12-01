require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of :credit_card_number }
    xit { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'methods' do
    it 'successful' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction, result: 'failed')
      transaction_3 = create(:transaction)

      result = Transaction.successful.sort

      expect(result.length).to eq(2) 
      expect(result).to eq([transaction_1, transaction_3]) 
    end
  end
end

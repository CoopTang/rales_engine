class Api::V1::Transactions::SearchController < ApplicationController

  def find
    transaction = Transaction.order(:id).find_by(transaction_search_params)
    render json: TransactionSerializer.new(transaction)
  end

  def find_all
    transactions = Transaction.order(:id).where(transaction_search_params)
    render json: TransactionSerializer.new(transactions)
  end

  def random
    transaction = Transaction.find(Transaction.pluck(:id).sample)
    render json: TransactionSerializer.new(transaction)
  end

  private

  def transaction_search_params
    params.permit(
      :id,
      :invoice_id,
      :credit_card_number,
      :result,
      :created_at,
      :updated_at
    )
  end
end
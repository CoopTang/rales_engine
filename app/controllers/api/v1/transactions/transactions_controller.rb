class Api::V1::Transactions::TransactionsController < ApplicationController

  def index
    transactions = Transaction.all
    render json: TransactionSerializer.new(transactions)
  end

  def show
    transaction = Transaction.find_by(id: params[:id])
    render json: TransactionSerializer.new(transaction)
  end
end
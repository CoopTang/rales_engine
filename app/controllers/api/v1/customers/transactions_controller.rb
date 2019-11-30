class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    customer = Customer.find_by(id: params[:customer_id])
    render json: TransactionSerializer.new(customer.transactions)
  end
end
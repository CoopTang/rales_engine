class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    transaction = Transaction.find_by(id: params[:transaction_id])
    render json: InvoiceSerializer.new(transaction.invoice)
  end
end
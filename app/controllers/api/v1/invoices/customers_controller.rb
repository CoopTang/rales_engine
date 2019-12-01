class Api::V1::Invoices::CustomersController < ApplicationController

  def show
    invoice = Invoice.find_by(id: params[:invoice_id])
    render json: CustomerSerializer.new(invoice.customer)
  end
end
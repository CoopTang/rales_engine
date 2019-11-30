class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    customer = Customer.find_by(id: params[:customer_id])
    render json: InvoiceSerializer.new(customer.invoices)
  end
end
class Api::V1::Invoices::InvoicesController < ApplicationController

  def index
    invoices = Invoice.all
    render json: InvoiceSerializer.new(invoices)
  end

  def show
    invoice = Invoice.find_by(id: params[:id])
    render json: InvoiceSerializer.new(invoice)
  end
end
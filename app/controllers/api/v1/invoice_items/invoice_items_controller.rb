class Api::V1::InvoiceItems::InvoiceItemsController < ApplicationController
  
  def index
    invoice_items = InvoiceItem.all
    render json: InvoiceItemSerializer.new(invoice_items)
  end

  def show
    invoice_item = InvoiceItem.find_by(id: params[:id])
    render json: InvoiceItemSerializer.new(invoice_item)
  end
end
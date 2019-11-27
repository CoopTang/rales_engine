class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    item = Item.find_by(id: params[:item_id])
    render json: InvoiceItemSerializer.new(item.invoice_items)
  end
end
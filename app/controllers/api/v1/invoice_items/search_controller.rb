class Api::V1::InvoiceItems::SearchController < ApplicationController
  before_action :convert_to_cents

  def find
    invoice_item = InvoiceItem.order(:id).find_by(invoice_item_search_params)
    render json: InvoiceItemSerializer.new(invoice_item)
  end

  def find_all
    invoice_items = InvoiceItem.order(:id).where(invoice_item_search_params)
    render json: InvoiceItemSerializer.new(invoice_items)
  end

  def random
    invoice_item = InvoiceItem.find(InvoiceItem.pluck(:id).sample)
    render json: InvoiceItemSerializer.new(invoice_item)
  end

  private

  def invoice_item_search_params
    params.permit(
      :id,
      :item_id,
      :invoice_id,
      :quantity,
      :unit_price,
      :created_at,
      :updated_at
    )
  end

  def convert_to_cents
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].delete('^0-9').to_i
    end
  end
end
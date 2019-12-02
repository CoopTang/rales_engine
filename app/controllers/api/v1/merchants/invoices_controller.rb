class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    merchant = Merchant.find_by(id: params[:merchant_id])
    render json: InvoiceSerializer.new(merchant.invoices.distinct.order(:id))
  end
end
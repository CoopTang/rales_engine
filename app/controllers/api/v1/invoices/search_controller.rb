class Api::V1::Invoices::SearchController < ApplicationController

  def find
    invoice = Invoice.order(:id).find_by(invoice_search_params)
    render json: InvoiceSerializer.new(invoice)
  end

  def find_all
    invoices = Invoice.order(:id).where(invoice_search_params)
    render json: InvoiceSerializer.new(invoices)
  end

  def random
    invoice = Invoice.find(Invoice.pluck(:id).sample)
    render json: InvoiceSerializer.new(invoice)
  end

  private

  def invoice_search_params
    params.permit(
      :id,
      :customer_id,
      :merchant_id,
      :status,
      :created_at,
      :updated_at
    )
  end
end
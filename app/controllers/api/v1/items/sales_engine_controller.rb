class Api::V1::Items::SalesEngineController < ApplicationController

  def most_revenue
    items = Item.most_revenue(params[:quantity])
    render json: ItemSerializer.new(items)
  end

  def best_day
    invoice = Item.find_by(id: params[:id]).best_day_invoice
    render json: best_day_serialized(invoice)
  end

  private

  def best_day_serialized(invoice)
    day = DateTime.parse(invoice.created_at.to_s).strftime("%Y-%m-%d")
    {
      data: {
        attributes: {
          best_day: day
        }
      }
    }
  end
end
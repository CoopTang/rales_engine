class Api::V1::Items::SalesEngineController < ApplicationController

  def most_revenue
    items = Item.most_revenue(params[:quantity])
    render json: ItemSerializer.new(items)
  end
end
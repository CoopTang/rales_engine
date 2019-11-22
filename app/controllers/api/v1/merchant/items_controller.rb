class Api::V1::Merchant::ItemsController < ApplicationController

  def index
    items = Item.where(merchant_id: params[:merchant_id])
    render json: ItemSerializer.new(items)
  end
end
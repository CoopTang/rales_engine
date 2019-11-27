class Api::V1::Items::SearchController < ApplicationController
  before_action :convert_to_cents

  def find
    item = Item.order(:id).find_by(item_search_params)
    render json: ItemSerializer.new(item)
  end

  def find_all
    items = Item.order(:id).where(item_search_params)
    render json: ItemSerializer.new(items)
  end

  def random
    item = Item.find(Item.pluck(:id).sample)
    render json: ItemSerializer.new(item)
  end

  private

  def item_search_params
    params.permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
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
class Api::V1::Items::SearchController < ApplicationController

  def find
    item = Item.find_by(item_search_params)
    render json: ItemSerializer.new(item)
  end

  def find_all
    items = Item.where(item_search_params)
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
      :created_at,
      :updated_at
    )
  end
end
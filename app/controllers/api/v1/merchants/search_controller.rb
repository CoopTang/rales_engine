class Api::V1::Merchants::SearchController < ApplicationController
  
  def find
    merchant = Merchant.find_by(merchant_search_params)
    render json: MerchantSerializer.new(merchant)
  end

  def find_all
    merchants = Merchant.where(merchant_search_params)
    render json: MerchantSerializer.new(merchants)
  end

  def random
    merchant = Merchant.find(Merchant.pluck(:id).sample)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
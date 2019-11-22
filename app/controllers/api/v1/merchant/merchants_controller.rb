class Api::V1::Merchant::MerchantsController < ApplicationController

  def index
    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)
  end

  def show
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
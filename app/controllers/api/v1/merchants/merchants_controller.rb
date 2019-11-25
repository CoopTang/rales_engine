class Api::V1::Merchants::MerchantsController < ApplicationController

  def index
    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end
class Api::V1::Customers::SalesEngineController < ApplicationController

  def favorite_merchant
    merchant = Customer.find_by(id: params[:id]).favorite_merchant
    render json: MerchantSerializer.new(merchant)
  end

end
class Api::V1::Merchants::SalesEngineController < ApplicationController

  def most_revenue
    merchants = Merchant.total_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
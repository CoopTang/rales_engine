class Api::V1::Merchants::SalesEngineController < ApplicationController

  def most_revenue
    merchants = Merchant.total_revenue(quantity: params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
  
  def revenue
    total_rev = Merchant.total_revenue_by_date(params[:date])
    total_rev = total_rev.first.total_revenue
    render json: serialized_total_revenue_by_date(total_rev)
  end

  def favorite_customer
    customer = Merchant.find_by(id: params[:id]).favorite_customer
    render json: CustomerSerializer.new(customer)
  end

  private

  def serialized_total_revenue_by_date(total_rev)
    {
      data: {
        attributes: {
          total_revenue: total_rev.to_i * 0.01
        }
      }
    }
  end

end
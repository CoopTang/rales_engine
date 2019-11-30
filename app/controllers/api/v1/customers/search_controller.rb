class Api::V1::Customers::SearchController < ApplicationController

  def find
    customer = Customer.order(:id).find_by(customer_search_params)
    render json: CustomerSerializer.new(customer)
  end

  def find_all
    customers = Customer.order(:id).where(customer_search_params)
    render json: CustomerSerializer.new(customers)
  end

  def random
    customer = Customer.find(Customer.pluck(:id).sample)
    render json: CustomerSerializer.new(customer)
  end

  private

  def customer_search_params
    params.permit(
      :id,
      :first_name,
      :last_name,
      :created_at,
      :updated_at
    )
  end
end
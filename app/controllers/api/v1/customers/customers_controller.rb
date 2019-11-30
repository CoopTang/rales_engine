class Api::V1::Customers::CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: CustomerSerializer.new(customers)
  end

  def show
    customer = Customer.find_by(id: params[:id])
    render json: CustomerSerializer.new(customer)
  end
end
class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    customers = Customer.all
    render json: customers, status: :ok
  end

  def create
    return unless user_logged?

    customer = Customer.new( customer_params )
    if customer.save
      render json: customer, status: :ok
    end
  end

  def show
    return unless user_logged?

    customer = Customer.find(params[:id])
    render json: customer, status: :ok
  end

  def update
    return unless user_logged?

    customer = Customer.find(params[:id])
    if customer.update( customer_params )
      render json: customer, status: :ok
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email)
  end
end

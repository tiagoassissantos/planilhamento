class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    customers = Customer.all
    render json: customers, status: :ok
  end

  def create
    return unless user_logged?
    customer_validation = Customer.find_by(email: params[:customer][:email] )


    unless customer_validation.nil?
      render json: {"status": "error", "message": "E-mail informado já está em uso"}, status: 500
      return
    end

    customer = Customer.new( customer_params )
    if customer.save
      @registry = customer.to_log
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
      @registry = customer.to_log
      render json: customer, status: :ok
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :salesman, :cpf_cnpj, :phone, :contact)
  end
end

class ConstructionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    constructions = Construction.all
    render json: constructions, status: :ok
  end

  def create
    customer = Customer.find( params[:customer_id][:id] )
    construction = Construction.new( construction_params )
    construction.customer = customer

    if construction.save
      @registry = construction.to_log
      render json: construction, status: :ok
    else
      render json: {'message': construction.errors.full_message}, status: :internal_server_error
    end
  end

  def show
    construction = Construction.find( params[:id] )
    render json: construction, status: :ok
  end

  def update
    customer = Customer.find( params[:customer_id][:id] )
    construction = Construction.find( params[:id] )
    construction.customer = customer

    construction.save

    if construction.update( construction_params )
      @registry = construction.to_log
      render json: construction, status: :ok
    else
      render json: {'message': construction.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    construction = Construction.find( params[:id])
    @registry = construction.to_log
    
    if construction.destroy
      render json: {'message': 'ok'}, status: :ok
    else
      render json: {'message': construction.errors.full_message}, status: :internal_server_error
    end
  end

  private
  def construction_params
    params.require(:construction).permit(:name, :contact_number, :email, :cpf_cnpj, :contact)
  end
end

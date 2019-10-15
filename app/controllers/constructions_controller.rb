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
    stage_construction_ids = params[:stage_construction_id]


    stage_construction_ids.each do |id|
      stage = StageConstruction.find( id )
      construction.stage_constructions << stage
    end


    if construction.save
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
    stage_construction_ids = params[:stage_construction_id]


    stage_construction_ids.each do |id|
      stage = StageConstruction.find( id )
      construction.stage_constructions << stage
    end

    construction.save

    if construction.update( construction_params )
      render json: construction, status: :ok
    else
      render json: {'message': construction.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    construction = Construction.find( params[:id])
    construction.customer = nil
    construction.save

    if construction.destroy
      render json: {'message': 'ok'}, status: :ok
    end
  end

  private
  def construction_params
    params.require(:construction).permit(:name, :contact_number, :email, :cpf_cnpj, :contact)
  end
end

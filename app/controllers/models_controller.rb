class ModelsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    models = Model.all

    render json: models, status: :ok
  end


  def create
    return unless user_logged?

    verify_model = Model.find_by(manufacturer_id: model_params[:manufacturer_id], name: model_params[:name])
    unless verify_model.nil?
      render json: {'message': 'Nome de modelo já utilizado'}, status: :internal_server_error
      return
    end

    model = Model.new( model_params )
    if model.save
      render json: model, status: :ok
    else
      render json: {'message': model.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    model = Model.find( params[:id])
    lot_items = LotItem.find_by(id: model.id )

    unless lot_items.nil?
      render json: {'message': 'O item não pode ser excluído pois existem itens cadastrados.'}, status: 401
      return
    end

    if model.delete
      render json: model, status: 200
    else
      render json: {'message': model.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?
    model = Model.find( params[:id] )
    render json: model, status: :ok
  end


  def by_manufacturer
    return unless user_logged?
    models = Model.where( manufacturer_id: params[:manufacturer_id] )
    render json: models, status: :ok
  end


  def update
    return unless user_logged?

    model = Model.find( params[:id] )

    if model.update( model_params )
      render json: model, status: 200
    else
      render json: {'message': model.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def model_params
    params.require(:model).permit(:name, :manufacturer_id)
  end
end

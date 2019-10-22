class StageItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    items = StageItem.where( construction_stage_id: params[:construction_stage_id] )
    render json: items, status: :ok
  end

  def show
    item = StageItem.find( params[:id] )
    render json: item, status: :ok
  end

  def create
    stage_item = StageItem.new( stage_item_params )
    stage_item.construction_stage_id = params[:construction_stage_id]
    
    if stage_item.save
      @registry = stage_item.to_log
      render json: stage_item, status: :ok
    else
      render json: {'message': stage_item.errors.full_message}, status: :internal_server_error
    end
  end

  def update
    item = StageItem.find( params[:id] )
    
    if item.update( stage_item_params )
      @registry = stage_item.to_log
      render json: item, status: :ok
    else
      render json: {'message': item.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    stage_item = StageItem.find(params[:id])
    @registry = stage_item.to_log
    if stage_item.destroy
      render json: { 'message': 'ok' }, status: :ok
    end
  end

  private
  def stage_item_params
    params.require(:stage_item).permit(:name, :abbreviation)
  end
end

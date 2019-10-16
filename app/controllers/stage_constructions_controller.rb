class StageConstructionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    construction_id = params[:construction_id]
    stage_constructions = StageConstruction.where( construction_id: construction_id )

    render json: stage_constructions, status: :ok
  end

  def create
    stage_construction = StageConstruction.new( stage_construction_params )
    stage_construction.construction_id = params[:construction_id]
    if stage_construction.save
      render json: stage_construction.id, status: :ok
    else
      render json: {'message': stage_construction.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    stage_construction = StageConstruction.find(params[:id])
    if stage_construction.delete
      render json: { 'message': 'ok' }, status: :ok
    end
  end

  def get_stage_by_construction
    stage_construction_ids = params[:stage_construction_id]
    stage_constructions = []

    stage_construction_ids.each do |id|
      stage = StageConstruction.find( id )
      stage_constructions << stage
    end

    render json: stage_constructions, status: :ok
  end

  def show
    stage_constructions = StageConstruction.where(construction_id: params[:id])
    render json: stage_constructions, status: :ok
  end

  private
  def stage_construction_params
    params.require(:stage_construction).permit(:name, :quantity, :pavement)
  end

end

class ConstructionStagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    construction_id = params[:construction_id]
    construction_stages = ConstructionStage.where( construction_id: construction_id )

    render json: construction_stages, status: :ok
  end

  def show
    stage = ConstructionStage.find( params[:id] )
    render json: stage, status: :ok
  end

  def create
    construction_stage = ConstructionStage.new( construction_stage_params )
    construction_stage.construction_id = params[:construction_id]

    if construction_stage.save
      @registry = construction_stage.to_log
      render json: construction_stage, status: :ok
    else
      render json: {'message': construction_stage.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    construction_stage = ConstructionStage.find(params[:id])
    @registry = construction_stage.to_log
    if construction_stage.destroy
      render json: { 'message': 'ok' }, status: :ok
    end
  end

  def get_stage_by_construction
    construction_stage_ids = params[:construction_stage_id]
    construction_stages = []

    construction_stage_ids.each do |id|
      stage = ConstructionStage.find( id )
      construction_stages << stage
    end

    render json: construction_stages, status: :ok
  end

  private
  def construction_stage_params
    params.require(:construction_stage).permit(:name, :quantity, :pavement)
  end

end

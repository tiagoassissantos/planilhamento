class ItemElementsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    elements = ItemElement.where( stage_item_id: params[:stage_item_id] ).order(:position)
    render json: elements, status: :ok
  end

  def create
    element = ItemElement.new( element_params )
    element.stage_item_id = params[:stage_item_id]

    if element.save
      render json: element, status: :created
    else
      render json: {'message': element.errors.full_message}, status: :internal_server_error
    end
  end

  def update
    element = ItemElement.find( params[:id] )

    if element.update( element_params )
      render json: element, status: :ok
    else
      render json: {'message': element.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    Rails.logger.info("++++++++++++++++++++++++")
    Rails.logger.info("++++++++++++++++++++++++")
    Rails.logger.info("++++++++++++++++++++++++")
    Rails.logger.info("++++++++++++++++++++++++")
    Rails.logger.info("++++++++++++++++++++++++")
  end

  private

  def element_params
    params.require(:element).permit(:position, :gauge, :quantity, :format_id, format_values: {})
  end

end

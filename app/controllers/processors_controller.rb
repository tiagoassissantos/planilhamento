class ProcessorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  
  def index
    return unless user_logged?

    processors = Processors.all

    render json: processors, status: :ok
  end


  def create
    return unless user_logged?

    processors = Processors.new( processors_type_params )

    if processors.save
      render json: processors, status: :ok
    else
      render json: {'message': processors.errors.full_message}, status: :internal_server_error
    end
  end

  private 
  def processors_type_params
    require(:processor).permit(:name)
  end
end

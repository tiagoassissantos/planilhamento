class ProcessorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    processors = Processor.all

    render json: processors, status: :ok
  end


  def create
    return unless user_logged?

    verify_processor = Processor.find_by(name: processor_params[:name])
    unless verify_processor.nil?
      render json: {'message': 'Nome do processador já utilizado'}, status: :internal_server_error
      return
    end

    processor = Processor.new( processor_params )
    if processor.save
      render json: processor, status: :ok
    else
      render json: {'message': processor.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    processor = Processor.find( params[:id])

    if processor.delete
      render json: processor, status: 200
    else
      render json: {'message': processor.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    processor = Processor.find( params[:id] )

    render json: processor, status: :ok
  end


  def update
    return unless user_logged?

    processor = Processor.find( params[:id] )

    if processor.update( processor_params )
      render json: processor, status: 200
    else
      render json: {'message': processor.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def processor_params
    params.require(:processor).permit(:name)
  end
end

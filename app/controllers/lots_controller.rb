class LotsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    status = params[:status]

    if status == 'all' or status == nil
      lots = Lot.all
      render json: lots, status: :ok
    end
    if status == 'closed'
      lots = Lot.where(:status => 'closed')
      render json: lots, status: :ok
    end
    if status == 'open'
      lots = Lot.where("(status = '0') or status = 2")
      render json: lots, status: :ok
    end
  end


  def create
    return unless user_logged?

    verify_lot = Lot.find_by(order_number: lot_params[:order_number])
    unless verify_lot.nil?
      render json: {'message': 'Nome de lote já utilizado'}, status: :internal_server_error
      return
    end

    lot = Lot.new( lot_params )
    if lot.save
      render json: lot, status: :ok
    else
      render json: {'message': lot.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    lot = Lot.find( params[:id])

    if lot.delete
      render json: lot, status: 200
    else
      render json: {'message': lot.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?
    lot = Lot.find( params[:id] )
    render json: lot, status: :ok
  end


  def update
    return unless user_logged?

    lot = Lot.find( params[:id] )

    if lot.update( lot_params )
      render json: lot, status: 200
    else
      render json: {'message': lot.errors.full_message}, status: :internal_server_error
    end
  end

  private
  def lot_params
    params.require(:lot).permit(:order_number, :status)
  end

end

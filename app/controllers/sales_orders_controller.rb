class SalesOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    sale_orders = SalesOrder.all
    render json: sale_orders, status: 200
  end

  def create
    verify_sales_order = SalesOrder.find_by(order_number: sales_orders_params[:order_number])
    unless verify_sales_order.nil?
      render json: {'message': 'Número do pedido já utilizado'}, status: :internal_server_error
      return
    end

    sales_order = SalesOrder.new(sales_orders_params)
    if sales_order.save
      render json: {'message': 'Pedido de Venda cadastrado com sucesso'}, status: 200
    end
  end

  def show
    sales_order = SalesOrder.find_by(id: params[:id])
    render json: sales_order, status: 200
  end

  def update
    sales_order = SalesOrder.find_by(id: params[:id])

    sales_order.update( sales_orders_params )
    if sales_order.save
      render json: sales_order, status: 200
    else
      render json: {'message': 'Erro ao atualizar pedido'}, status: :internal_server_error
    end
  end

  def add_item
    sales_orders = SalesOrder.find_by(id: params[:sales_order_id])
    lot_item = LotItem.find_by(id: params[:lot_id])
    destination = Destination.find_by(id: 2)
    lot_item.update_attributes(:sales_order => sales_orders, :destination => destination)

    if lot_item.save
      render json: {'message': 'Item adicionado ao pedido com sucesso. '}, status: 200
    else
      render json: {'message': 'Erro ao adicionar item. '}, status: :internal_server_error
    end
  end

  private
  def sales_orders_params
    params.require(:sales_order).permit(:order_number)
  end
end

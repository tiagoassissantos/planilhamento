class SalesOrdersItemsController < ApplicationController
  def index
    sales_orders = SalesOrder.find_by(id: params[:sales_order_id])
    render json: sales_orders.lot_items, status: 200
  end
end

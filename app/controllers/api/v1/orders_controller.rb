class Api::V1::OrdersController < Api::V1::ApplicationController
  before_action :load_orders, only: :index
  before_action :load_order, only: [:show, :update]

  def index
    render json: @orders, root: "data", status: 200
  end

  def show
    render json: @order, show_details: true, root: "data", status: 200
  end

  def create
    @order = current_user.orders.build order_params
    if @order.save
      render json: @order, root: "data", status: 200
    else
      render json: {
        errors: {
          code: I18n.t("errors.api.orders.create_failed"),
          messages: @order.errors.full_messages
        }
      }, root: "data", status: 400
    end
  end

  def update
    if @order.update order_params
      render json: @order, root: "data", status: 200
    else
      render json: {
        errors: {
          code: I18n.t("errors.api.orders.update_failed"),
          messages: @order.errors.full_messages
        }
      }, root: "data", status: 400
    end
  end

  private
  def order_params
    params.require(:order).permit :description, :address, :total, :estimate_time,
      :user_request_time, :total, orders_products_attributes: [:product_id,
        :price, :quantity, :description, :_destroy]
  end

  def load_orders
    @orders = current_user.orders
  end

  def load_order
    unless @order = Order.find_by(id: params[:id])
      render json: I18n.t("errors.api.not_found", model: Order.name), status: 400
    end
  end
end

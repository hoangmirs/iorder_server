class Api::V1::SalesController < Api::V1::ApplicationController
  before_action :load_sales, only: :index
  before_action :load_sale, only: :show

  def index
    render json: @sales, root: "data", status: 200
  end

  def show
    render json: @sale, root: "data", status: 200
  end

  private
  def load_sales
    @sales = Sale.all
  end

  def load_sale
    unless @sale = Sale.find_by(id: params[:id])
      render json: I18n.t("errors.api.not_found", model: Sale.name), status: 400
    end
  end
end

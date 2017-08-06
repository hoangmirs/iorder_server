class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :load_products, :paginate, only: :index
  before_action :load_product, only: :show

  def index
    render json: @products, root: "data", status: 200
  end

  def show
    render json: @product, root: "data", status: 200
  end

  private
  def load_products
    @products = Product.search_by params
  end

  def paginate
    @products = paginate_array @products, params[:page], Settings.pagination_default.products
  end

  def load_product
    unless @product = Product.find_by(id: params[:id])
      render json: {errors: I18n.t("errors.api.not_found", model: Product.name)},
        status: 400
    end
  end
end

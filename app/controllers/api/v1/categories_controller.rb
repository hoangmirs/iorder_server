class Api::V1::CategoriesController < Api::V1::ApplicationController
  before_action :load_categories, only: :index
  before_action :load_category, only: :show

  def index
    render json: @categories, root: "data", status: 200
  end

  def show
    render json: @category, show_products: true, page: params[:page],
      root: "data", status: 200
  end

  private
  def load_categories
    @categories = if params[:key_word]
      Category.by_key_word params[:key_word]
    else
      Category.all
    end
  end

  def load_category
    unless @category = Category.find_by(id: params[:id])
      render json: {errors: I18n.t("errors.api.not_found", model: Category.name)},
        status: 400
    end
  end
end

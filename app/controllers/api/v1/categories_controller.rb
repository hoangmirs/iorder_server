class Api::V1::CategoriesController < Api::V1::ApplicationController
  before_action :load_categories, only: :index

  def index
    render json: @categories, root: "data", status: 200
  end

  private
  def load_categories
    @categories = Category.all
  end
end

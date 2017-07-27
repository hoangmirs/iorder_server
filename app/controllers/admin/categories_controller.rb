class Admin::CategoriesController < Admin::BaseController
  before_action :set_breadcrums
  before_action :load_categories, only: :index
  before_action :load_category, except: :index

  def index
  end

  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy

    else

    end
    redirect_to admin_categories_path
  end

  private
  def set_breadcrums
    if params[:action] != "index"
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.index"), :admin_categories_path
    end
    add_breadcrumb I18n.t("admin.breadcrumbs.categories.#{params[:action]}"), :admin_categories_path
  end

  def load_categories
    @categories = Category.all.page(params[:page]).per Settings.pagination_default.categories
  end

  def load_category
    @category = if params[:id]
      Category.find_by id: params[:id]
    else
      Category.new
    end
  end

  def category_params
    params.require(:category).permit :name, :description, :image
  end
end

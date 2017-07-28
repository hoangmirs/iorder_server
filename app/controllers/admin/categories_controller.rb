class Admin::CategoriesController < Admin::BaseController
  before_action :load_categories, only: :index
  before_action :load_category, except: :index
  before_action :set_breadcrums

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
    @category.destroy
    redirect_to admin_categories_path
  end

  private
  def set_breadcrums
    if params[:action] != "index"
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.index"), :admin_categories_path
    end
    case params[:action].to_sym
    when :index
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.index"), :admin_categories_path
    when :new, :create
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.#{params[:action]}"), :new_admin_category_path
    when :edit, :update
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.#{params[:action]}"), :edit_admin_category_path
    when :show
      add_breadcrumb I18n.t("admin.breadcrumbs.categories.#{params[:action]}"), :admin_category_path
    end
  end

  def load_categories
    @categories = Category.joins("left outer join products on products.id = categories.id")
      .select("categories.*, count(products.id) as product_count").group("categories.id")
      .page(params[:page]).per Settings.pagination_default.categories
  end

  def load_category
    @category = if params[:id]
      Category.joins("left outer join products on products.id = categories.id")
        .select("categories.*, count(products.id) as product_count").group("categories.id").find_by id: params[:id]
    else
      Category.new
    end
  end

  def category_params
    params.require(:category).permit :name, :description, :image
  end
end

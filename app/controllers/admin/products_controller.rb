class Admin::ProductsController < Admin::BaseController
  before_action :load_products, only: :index
  before_action :load_product, except: :index
  before_action :set_breadcrums

  def index
  end

  def new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  private
  def set_breadcrums
    if params[:action] != "index"
      add_breadcrumb I18n.t("admin.breadcrumbs.products.index"), :admin_products_path
    end
    case params[:action].to_sym
    when :index
      add_breadcrumb I18n.t("admin.breadcrumbs.products.index"), :admin_products_path
    when :new, :create
      add_breadcrumb I18n.t("admin.breadcrumbs.products.#{params[:action]}"), :new_admin_product_path
    when :edit, :update
      add_breadcrumb I18n.t("admin.breadcrumbs.products.#{params[:action]}"), :edit_admin_product_path
    when :show
      add_breadcrumb I18n.t("admin.breadcrumbs.products.#{params[:action]}"), :admin_product_path
    end
  end

  def load_products
    @products = Product.joins("join categories ON categories.id = products.id")
      .select("products.*, categories.name as category_name")
      .page(params[:page]).per Settings.pagination_default.products
  end

  def load_product
    @product = if params[:id]
      Product.find_by id: params[:id]
    else
      Product.new
    end
  end

  def product_params
    params.require(:product).permit :category_id, :name, :description, :image, :price, :cost_time
  end
end

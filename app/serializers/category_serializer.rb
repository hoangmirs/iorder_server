class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image

  attribute :products, if: :show_products?

  def image
    object.image.try :url
  end

  def products
    products = if page
      object.products.page(page).per Settings.pagination_default.products
    else
      object.products
    end
    ActiveModel::Serializer::CollectionSerializer.new products
  end

  def show_products?
    @instance_options[:show_products]
  end

  def page
    @instance_options[:page]
  end
end

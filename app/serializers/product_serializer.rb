class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :price, :status, :cost_time,
    :category_id

  def image
    object.image.try :url
  end
end

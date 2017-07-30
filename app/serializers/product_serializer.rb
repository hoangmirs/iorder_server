class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :price, :status, :cost_time

  def image
    object.image.try :url
  end
end

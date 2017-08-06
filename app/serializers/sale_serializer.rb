class SaleSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :code, :apply_all, :genre, :num,
    :image, :start_time, :end_time

  def image
    object.image.try :url
  end
end

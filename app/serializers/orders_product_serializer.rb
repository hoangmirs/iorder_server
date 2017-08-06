class OrdersProductSerializer < ActiveModel::Serializer
  attributes :id, :description, :quantity, :price, :product
end

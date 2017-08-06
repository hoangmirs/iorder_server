class OrderSerializer < ActiveModel::Serializer
  attributes :id, :description, :address, :total, :estimate_time,
    :user_request_time, :total, :status, :is_paid

  has_many :orders_products, if: :show_details?

  def show_details?
    @instance_options[:show_details]
  end
end

class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  belongs_to :category

  validates :name, :description, presence: true, length: {maximum: 255}
  validates :price, :cost_time, :image, presence: true

  scope :search_by, -> params do
    params[:status] ||= 1
    params[:price_cond] ||= Settings.ransack.lteq
    params[:cost_time_cond] ||= Settings.ransack.lteq
    condition = {category_id_eq: params[:category_id], name_cont: params[:name],
      description_cont: params[:description], status: params[:status]}
    condition.merge! "price_#{params[:price_cond]}": params[:price] if params[:price]
    condition.merge! "cost_time_#{params[:cost_time_cond]}": params[:cost_time] if params[:cost_time]
    ransack(condition).result
  end
end

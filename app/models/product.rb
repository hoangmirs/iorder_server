class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  belongs_to :category

  validates :name, :description, presence: true, length: {maximum: 255}
  validates :price, :cost_time, :image, presence: true
end

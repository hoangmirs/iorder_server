class Category < ApplicationRecord
  mount_uploader :image, CategoryImageUploader

  validates :name, presence: true, uniqueness: true, length: {maximum: 255}
  validates :description, presence: true, length: {maximum: 255}
  validates :image, presence: true
end

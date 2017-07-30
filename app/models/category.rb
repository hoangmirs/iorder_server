class Category < ApplicationRecord
  mount_uploader :image, CategoryImageUploader
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: {maximum: 255}
  validates :description, presence: true, length: {maximum: 255}
  validates :image, presence: true

  scope :by_key_word, -> key_word {ransack(name_or_description_cont: key_word.to_s.strip).result}
end

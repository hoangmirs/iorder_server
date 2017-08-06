class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_products

  enum status: [:pending, :cancelled, :processing, :done]
  accepts_nested_attributes_for :orders_products

  validates :orders_products, presence: true
  validates :total, presence: true
end

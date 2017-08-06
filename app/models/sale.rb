class Sale < ApplicationRecord
  mount_uploader :image, SaleImageUploader

  has_many :products_sales, dependent: :destroy
  has_many :products, through: :products_sales
  has_many :categories, through: :products

  validates :name, presence: true
  validates :genre, presence: true
  validates :num, presence: true
  validates :start_time, :end_time, presence: true

  enum genre: [:percent, :currency]

  scope :apply_all, -> {where apply_all: true}
  scope :not_apply_all, -> {where apply_all: false}
  scope :available, -> current_time = Time.current do
    ransack(start_time_lteq: :current_time, end_time_gteq: :current_time,
      current_time: current_time).result
  end
  scope :not_available, -> current_time = Time.current do
    ransack(start_time_lteq: :current_time, end_time_gteq: :current_time,
      current_time: current_time).result
  end
  scope :search_by, -> params do
    available.ransack(categories_id_eq: params[:category_id],
      apply_all_eq: params[:apply_all]).result
  end

  class << self
    def generate_sales_code
      code = loop do
        code = Settings.sale.code.max_length.times.map {[*0..9, *"A".."Z"].sample}.join
        break code unless Sale.exists? code
      end
    end
  end
end

class CreateProductsSales < ActiveRecord::Migration[5.1]
  def change
    create_table :products_sales do |t|
      t.references :product, foreign_key: true
      t.references :sale, foreign_key: true

      t.timestamps
    end
  end
end

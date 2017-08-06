class CreateOrdersProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_products do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end

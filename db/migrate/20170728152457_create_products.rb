class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :price
      t.integer :status
      t.float :cost_time
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

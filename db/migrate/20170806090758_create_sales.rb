class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.text :description
      t.string :code
      t.boolean :apply_all
      t.integer :genre
      t.float :num
      t.string :image
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end

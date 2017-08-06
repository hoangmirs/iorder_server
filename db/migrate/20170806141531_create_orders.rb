class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :description
      t.string :address
      t.datetime :user_request_time
      t.bigint :estimate_time
      t.integer :total
      t.integer :status, default: 0
      t.boolean :is_paid, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

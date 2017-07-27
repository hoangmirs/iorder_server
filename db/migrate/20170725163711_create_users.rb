class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.integer :gender
      t.string :email
      t.datetime :birthday
      t.string :address
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

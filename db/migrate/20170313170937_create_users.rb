class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :postal
      t.string :country
      t.string :email
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end

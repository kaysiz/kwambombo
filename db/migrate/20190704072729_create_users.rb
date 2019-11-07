class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :business_name
      t.string :email, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

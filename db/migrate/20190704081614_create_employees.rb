class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :full_name, null: false
      t.integer :status, null: false, default: 0
      t.string :role, null: false, default: "cleaner"
      t.timestamps
    end
  end
end

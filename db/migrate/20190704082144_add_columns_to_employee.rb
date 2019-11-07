class AddColumnsToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :phone_number, :string
    add_column :employees, :ranking, :integer, default: 0
  end
end

class AddColumnsToCleanRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :clean_requests, :price, :string, null: false
    add_column :clean_requests, :frequency, :string, null: false
  end
end

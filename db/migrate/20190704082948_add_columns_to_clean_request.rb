class AddColumnsToCleanRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :clean_requests, :cleaner, :integer
  end
end

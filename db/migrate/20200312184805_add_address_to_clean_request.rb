class AddAddressToCleanRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :clean_requests, :address, :string
  end
end

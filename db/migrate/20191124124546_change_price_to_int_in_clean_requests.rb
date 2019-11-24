class ChangePriceToIntInCleanRequests < ActiveRecord::Migration[5.2]
  def change
    change_column :clean_requests, :price, :integer, using: 'price::integer'
  end
end

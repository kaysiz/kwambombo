class AddDefaultToPyamentStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :clean_requests, :payment_status, 'pending'
  end
end

class AddColumnPaymentStatusToCleanRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :clean_requests, :payment_status, :string, default: "pending"
  end
end

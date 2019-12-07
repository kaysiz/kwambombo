class RenamePaymentMenthodToPapymentMethod < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :payment_menthod, :payment_method
    rename_column :payments, :pay_request_id, :payment_request_id
  end
end

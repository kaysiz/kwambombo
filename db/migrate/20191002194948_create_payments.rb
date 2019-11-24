class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :reference_id
      t.string :amount
      t.string :payment_menthod
      t.string :pay_request_id
      t.string :status
      t.timestamps
    end
  end
end

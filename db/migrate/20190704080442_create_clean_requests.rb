class CreateCleanRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :clean_requests do |t|
      t.string :sector, null: false
      t.string :package, null:false
      t.string :days, null: false
      t.string :payment, null: false
      t.string :status, null: false, default: "pending"
      t.timestamps
    end
  end
end

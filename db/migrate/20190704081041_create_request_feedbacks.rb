class CreateRequestFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :request_feedbacks do |t|
      t.integer :rating, null: false, default: 1
      t.text :comment, null: false, default: "no comment"
      t.timestamps
    end
  end
end

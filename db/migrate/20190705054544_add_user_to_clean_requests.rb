class AddUserToCleanRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :clean_requests, :user, foreign_key: true
  end
end

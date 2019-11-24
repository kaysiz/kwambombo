class AlterCleanRequestsTable < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    add_column :clean_requests, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    
    change_table :clean_requests do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE clean_requests ADD PRIMARY KEY (id);"
  end
end

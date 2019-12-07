class RenameReferenceIdToChecksumInPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :reference_id, :checksum
  end
end

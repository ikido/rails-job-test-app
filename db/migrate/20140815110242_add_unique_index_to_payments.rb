class AddUniqueIndexToPayments < ActiveRecord::Migration
  def change
    add_index :payments, [:line_item_id, :service_id], unique: true
  end
end

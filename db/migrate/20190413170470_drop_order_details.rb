class DropOrderDetails < ActiveRecord::Migration[5.2]
  def change
    drop_table :order_details 
  end
end

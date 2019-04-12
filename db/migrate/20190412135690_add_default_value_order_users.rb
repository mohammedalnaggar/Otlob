class AddDefaultValueOrderUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :order_users, :status, :integer, default: 0
  end
end

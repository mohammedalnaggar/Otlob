class CreateOrderUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :order_users do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

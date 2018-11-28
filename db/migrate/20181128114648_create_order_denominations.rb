class CreateOrderDenominations < ActiveRecord::Migration[5.2]
  def change
    create_table :order_denominations do |t|
      t.integer :order_id, foreign_key: true, null: false
      t.integer :denomination_id, foreign_key: true, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end
end

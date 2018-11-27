class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :quote_id, foreign_key: true, null: false
      t.string :status, default: 'unfulfilled'
      t.timestamps
    end
  end
end

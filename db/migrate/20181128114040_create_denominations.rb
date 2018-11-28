class CreateDenominations < ActiveRecord::Migration[5.2]
  def change
    create_table :denominations do |t|
      t.integer :currency_id, foreign_key: true, null: false
      t.integer :amount, null: false
      t.decimal :value, null: false
      t.timestamps
    end
  end
end

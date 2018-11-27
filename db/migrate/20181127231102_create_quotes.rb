class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.integer :currency_id, foreign_key: true, null: false
      t.decimal :requested_value
      t.decimal :offered_value
      t.decimal :exchange_rate
      t.string :status, default: 'offered'
      t.timestamps
    end
  end
end

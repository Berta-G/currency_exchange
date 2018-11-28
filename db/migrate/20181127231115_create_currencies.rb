class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :code, index: true, uniq: true, null: false
      t.decimal :exchange_rate
      t.timestamps
    end
  end
end

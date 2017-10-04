class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.string :credit_card_number
      t.string :result
      t.datetime :transaction_created
      t.datetime :transaction_updated

      t.timestamps null:false
    end
  end
end

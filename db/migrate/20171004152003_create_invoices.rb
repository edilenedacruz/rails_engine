class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'
    
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true
      t.string :status

       t.timestamps null: false
    end
  end
end

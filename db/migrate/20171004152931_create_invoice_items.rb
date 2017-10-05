class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'
    
    create_table :invoice_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.integer :unit_price

      t.timestamps null:false
    end
  end
end

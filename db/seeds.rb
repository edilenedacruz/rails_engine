require 'csv'
require './app/models/customer.rb'
require './app/models/invoice_item.rb'
require './app/models/invoice.rb'
require './app/models/item.rb'
require './app/models/merchant.rb'
require './app/models/transaction.rb'

Transaction.destroy_all
InvoiceItem.destroy_all
Invoice.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

class Seed

  def self.start
    s = Seed.new
    s.seed_customers
    s.seed_merchants
    s.seed_items
    s.seed_invoices
    s.seed_invoice_items
    s.seed_transactions
  end

  def seed_customers
    CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    puts "Customers seeded."
  end

  def seed_merchants
    CSV.foreach('db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
      end
    puts "Merchants seeded."
  end

  def seed_items
    CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_h)
      end
    puts "Items seeded."
  end

  def seed_invoices
    CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_h)
      end
    puts "Invoices seeded."
  end

  def seed_invoice_items
    CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_h)
      end
    puts "Invoice Items seeded."
  end

  def seed_transactions
    CSV.foreach('db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_h)
      end
      puts "Transactions seeded."
  end
end

Seed.start

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :transactions
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
end

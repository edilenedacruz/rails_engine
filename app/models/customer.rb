class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :items, through: :merchants

  validates :first_name, :last_name, presence: true


end

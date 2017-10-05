class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :items, through: :merchants

  validates :first_name, :last_name, presence: true

  def favorite_merchant
    merchants.joins(:transactions, :invoices)
      .merge(Transaction.success)
      .select('merchants.*, count(invoices.customer_id) AS orders')
      .group('merchants.id')
      .order('orders DESC')
      .first
  end
end

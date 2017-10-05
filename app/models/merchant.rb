class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :transactions
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .group(:id)
    .select('merchants.*, SUM(invoice_items.quantity) AS total_items_sold')
    .order('total_items_sold DESC')
    .limit(quantity)
  end

  def self.date_total_revenue(date)
    joins(invoices: [:transactions, :invoice_items])
      .where('invoices.created_at = ?', date)
      .merge(Transaction.success)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end

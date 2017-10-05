class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def self.most_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order('SUM (invoice_items.quantity * invoice_items. unit_price) DESC ')
      .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order('COUNT (invoice_items.quantity) DESC ')
      .limit(quantity)
  end

  def best_day
    invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.success)
      .group('invoices.id')
      .order('sum(invoice_items.quantity) DESC')
      .first
      .created_at
  end
end

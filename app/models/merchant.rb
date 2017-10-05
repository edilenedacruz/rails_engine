class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
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

  def revenue(date)
    has_date(date)
      .joins(:transactions, :invoice_items)
      .merge(Transaction.success)
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def has_date(date)
    if date
      invoices.where(created_at: Time.zone.parse(date))
    else
      invoices
    end
  end

  def favorite_customer
    customers
    .select('customers.*, count(invoices.merchant_id) AS frequency')
    .joins(:invoices, :transactions)
      .merge(Transaction.success)
      .group('customers.id')
      .order('frequency DESC')
      .first
  end

  # def customers_with_pending_invoices
  # boss mode
  #   # binding.pry
  #   customers
  #   # .select('customers.*, count(invoices.merchant_id) AS purchases')
  #   .joins(:invoices, :transactions)
  #   .where.not(Transaction.success)
  #   # self.customers.joins(:invoices, :transactions).where.not(status: 'success').select('customers.*')
  # end
end

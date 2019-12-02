class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.total_revenue(quantity: Merchant.all.length)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(items: [invoice_items: [invoice: [:transactions]]])
      .merge(Transaction.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.total_revenue_by_date(date)
    # date = Date.parse(date)
    # rev = find_by_sql(
    #   "
    #   SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue FROM \"merchants\" 
    #   INNER JOIN \"items\" ON \"items\".\"merchant_id\" = \"merchants\".\"id\" 
    #   INNER JOIN \"invoice_items\" ON \"invoice_items\".\"item_id\" = \"items\".\"id\" 
    #   INNER JOIN \"invoices\" ON \"invoices\".\"id\" = \"invoice_items\".\"invoice_id\" 
    #   INNER JOIN \"transactions\" ON \"transactions\".\"invoice_id\" = \"invoices\".\"id\" 
    #   WHERE \"transactions\".\"result\" = 'success' 
    #   AND \"invoices\".\"created_at\" BETWEEN '#{date.beginning_of_day}' AND '#{date.end_of_day}'
    #   "
    # ).pluck(:total_revenue)
    binding.pry
    # select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    #   .joins(items: [invoice_items: [invoice: [:transactions]]])
    #   .merge(Transaction.successful)
    #   .merge(Invoice.on_date(date))
  end

  def favorite_customer
    customers.select('customers.*, COUNT(invoices.*) AS qty')
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('qty DESC')
      .first
  end
end

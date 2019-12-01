class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def self.total_revenue(quantity = 1, date = nil)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(items: [:invoice_items, invoices: [:transactions]])
      .merge(Transaction.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end
end

class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 1)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items, invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  end

  def best_day_invoice
    invoice_items
      .joins(:invoice)
      .order('invoice_items.quantity DESC, invoices.created_at DESC')
      .first.invoice
  end
end

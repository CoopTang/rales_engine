class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, COUNT(invoices.*) AS qty')
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order('qty DESC')
      .first
  end
end

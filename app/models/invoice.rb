class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  belongs_to :merchant
  has_many   :transactions
  has_many   :invoice_items
  has_many   :items, through: :invoice_items

  def self.on_date(date_str)
    date = Date.parse(date_str)
    where(created_at: date.all_day)
  end
end

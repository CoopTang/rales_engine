class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  attribute :unit_price do |invoice_item|
    (invoice_item.unit_price * 0.01).round(2).to_s
  end
end

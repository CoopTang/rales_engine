require 'csv'

namespace :import_csv do
  task :create_customers => :environment do
    customers_text = File.read('./data/customers.csv')
    customers_csv = CSV.parse(customers_text, headers: true)
    customers_csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  task :create_merchants => :environment do
    merchants_text = File.read('./data/merchants.csv')
    merchants_csv = CSV.parse(merchants_text, headers: true)
    merchants_csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task :create_invoices => :environment do
    invoices_text = File.read('./data/invoices.csv')
    invoices_csv = CSV.parse(invoices_text, headers: true)
    invoices_csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  task :create_items => :environment do
    items_text = File.read('./data/items.csv')
    items_csv = CSV.parse(items_text, headers: true)
    items_csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  task :create_transactions => :environment do
    transactions_text = File.read('./data/transactions.csv')
    transactions_csv = CSV.parse(transactions_text, headers: true)
    transactions_csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task :create_invoice_items => :environment do
    invoice_items_text = File.read('./data/invoice_items.csv')
    invoice_items_csv = CSV.parse(invoice_items_text, headers: true)
    invoice_items_csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end

task :all => [
  'import_csv:create_customers',
  'import_csv:create_merchants',
  'import_csv:create_invoices',
  'import_csv:create_items',
  'import_csv:create_transactions',
  'import_csv:create_invoice_items'
]

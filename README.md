## RalesEngine
A sales analysis API built using Ruby on Rails.


## Code style
If you would like to contribute, this project follows Ruby/RuboCop conventions.

[![ruby-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/rubocop-hq/ruby-style-guide)

## Tech/framework used
<b>Built with</b>
- [Rails 5.2.3](https://rubyonrails.org/)



## Installation
### Requirements
- [Ruby 2.4.1](https://github.com/ruby/ruby)
- [Rails 5.2.3](https://rubyonrails.org/)
- [PostgreSQL-11](https://www.postgresql.org/)

Once these are installed, clone the repository to your local machine with one of the following commands:

**HTTPS**

`git clone https://github.com/CoopTang/rales_engine.git`

**SSH**

`git clone git@github.com:CoopTang/rales_engine.git`

Once cloned onto your computer, `cd` into the project directory and run `bundle install ` to install all required gems for the project.

**Database Setup**

Run the following command to set up the database

```
rails db:{drop,create,migrate}
rake all
```

## API Reference

The following are a list of endpoints that can be used:

**Merchant**
```
GET  /api/v1/merchants/:merchant_id/items                                                                     GET  /api/v1/merchants/:merchant_id/invoices                                                                  GET  /api/v1/merchants/find?<resource attributes>
GET  /api/v1/merchants/find_all?<resource attributes>
GET  /api/v1/merchants/random
GET  /api/v1/merchants/most_revenue?quantity=<number>
GET  /api/v1/merchants/revenue?date=<date>
GET  /api/v1/merchants/:id/favorite_customer
GET  /api/v1/merchants
GET  /api/v1/merchants/:id
```
**Item**
```
GET  /api/v1/items/:item_id/merchant
GET  /api/v1/items/:item_id/invoice_items
GET  /api/v1/items/find?<resource attributes>
GET  /api/v1/items/find_all?<resource attributes>
GET  /api/v1/items/random
GET  /api/v1/items/most_revenue?quantity=<number>
GET  /api/v1/items/:id/best_day
GET  /api/v1/items
GET  /api/v1/items/:id
```
**Invoice**
```
GET  /api/v1/invoices/:invoice_id/transactions
GET  /api/v1/invoices/:invoice_id/items
GET  /api/v1/invoices/:invoice_id/invoice_items
GET  /api/v1/invoices/:invoice_id/customer
GET  /api/v1/invoices/:invoice_id/merchant
GET  /api/v1/invoices/find?<resource attributes>
GET  /api/v1/invoices/find_all?<resource attributes>
GET  /api/v1/invoices/random
GET  /api/v1/invoices
GET  /api/v1/invoices/:id
```
**InvoiceItem**
```
GET  /api/v1/invoice_items/:invoice_item_id/item
GET  /api/v1/invoice_items/:invoice_item_id/invoice
GET  /api/v1/invoice_items/find?<resource attributes>
GET  /api/v1/invoice_items/find_all?<resource attributes>
GET  /api/v1/invoice_items/random
GET  /api/v1/invoice_items
GET  /api/v1/invoice_items/:id
```
**Transaction**
```GET  /api/v1/transactions/find?<resource attributes>
GET  /api/v1/transactions/find_all?<resource attributes>
GET  /api/v1/transactions/random
GET  /api/v1/transactions
GET  /api/v1/transactions/:id
```
**Customer**
```
GET  /api/v1/customers/:customer_id/invoices
GET  /api/v1/customers/:customer_id/transactions
GET  /api/v1/customers/find?<resource attributes>
GET  /api/v1/customers/find_all?<resource attributes>
GET  /api/v1/customers/random
GET  /api/v1/customers/:id/favorite_merchant
GET  /api/v1/customers
GET  /api/v1/customers/:id
```

## Tests
[RSpec](https://github.com/rspec/rspec-rails) is the testing framwork used for testing.

**To run all tests**

`bundle exec rspec`

This will run all tests in the `/spec` directory.


**To run an entire test file**

`bundle exec rspec spec/<path to specifc test>`

**To run a specific test in a file**

`bundle exec rspec spec/<path to specifc test>:<line number of the test>`


## How to use?
To start the server and view the site from the browser, start the server with `rails s` . By default, the server runs on http://localhost:3000

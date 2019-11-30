FactoryBot.define do
  factory :customer do
    sequence :first_name do |n|
      "first_name_#{n}"
    end
    sequence :last_name do |n|
      "last_name_#{n}"
    end

    factory :customer_with_invoices do 
      sequence :first_name do |n|
        "first_name_#{n}"
      end
      sequence :last_name do |n|
        "last_name_#{n}"
      end
      after :create do |customer|
        create_list(:invoice_with_transactions, 3, customer: customer)
      end
    end
  end
end

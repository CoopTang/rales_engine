FactoryBot.define do
  factory :customer do
    sequence :first_name do |n|
      "first_name_#{n}"
    end
    sequence :last_name do |n|
      "last_name_#{n}"
    end
  end
end

# This will guess the User class
FactoryGirl.define do

  factory :post do
    title { Faker::Lorem.sentence }
  end

  factory :payment do
    status 'new'
  end

end
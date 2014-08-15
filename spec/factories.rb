# This will guess the User class
FactoryGirl.define do

  factory :post do
    title { Faker::Lorem.sentence }
  end

end
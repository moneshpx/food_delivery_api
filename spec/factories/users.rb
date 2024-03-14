FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    # Add any other attributes you want to set for the user
  end
end
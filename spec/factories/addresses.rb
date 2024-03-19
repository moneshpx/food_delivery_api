FactoryBot.define do
  factory :address do
    address { "MyString" }
    street { "MyString" }
    landmark { "MyString" }
    label { "MyString" }
    postal_code { 1 }
    user { nil }
  end
end

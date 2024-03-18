FactoryBot.define do
  factory :address do
    address { "MyString" }
    street { "MyString" }
    post_code { 1 }
    landmark { "MyString" }
    label { "MyString" }
    user { nil }
  end
end

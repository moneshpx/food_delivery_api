FactoryBot.define do
  factory :food do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    image_url { "MyString" }
    ingredints_basic { "MyString" }
    fruits { "MyString" }
    user { nil }
  end
end

FactoryBot.define do
  factory :offer do
    title { "MyString" }
    fixed_discount { 1 }
    percentage_discount { 1 }
    code { "MyString" }
    detail { "MyText" }
    valid_from { "2024-03-26" }
    valid_until { "2024-03-26" }
    restaurant { nil }
    item { nil }
    category { nil }
  end
end

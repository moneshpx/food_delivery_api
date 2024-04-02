FactoryBot.define do
  factory :order do
    user { nil }
    item { nil }
    quantity { 1 }
    status { "MyString" }
  end
end

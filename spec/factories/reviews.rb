FactoryBot.define do
  factory :review do
    rating { 1 }
    comment { "MyText" }
    user { nil }
    restaurant { nil }
    item { nil }
  end
end

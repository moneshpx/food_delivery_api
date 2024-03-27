FactoryBot.define do
  factory :cart_item do
    cart { nil }
    item { nil }
    quantity { 1 }
    unit_price { "9.99" }
    subtotal { "9.99" }
  end
end

FactoryBot.define do
  factory :markets_products, class: 'MarketsManagementApi::Models::MarketProduct' do
    price { Faker::Commerce.price(range: 0..100.00, as_string: false) }
    association :market, factory: :markets
    association :product, factory: :products
  end
end

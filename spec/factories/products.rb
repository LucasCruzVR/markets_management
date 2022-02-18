FactoryBot.define do
  factory :products, class: 'MarketsManagementApi::Models::Product' do
    name { Faker::Name.name }
    category { 0 }
    barcode { Faker::Number.number(digits: 13) }
  end
end

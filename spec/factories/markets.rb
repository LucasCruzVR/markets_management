FactoryBot.define do
  factory :markets, class: 'MarketsManagementApi::Models::Market' do
    name { Faker::Name.name }
    phone { Faker::Number.number(digits: 10) }
    address { Faker::Address.full_address }
  end
end

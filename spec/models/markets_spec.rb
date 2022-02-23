require 'rails_helper'

RSpec.describe MarketsManagementApi::Models::Market, type: :model do
  context 'Associations' do
    it { should have_many(:markets_products).inverse_of(:market) }
    it { should accept_nested_attributes_for(:markets_products) }
  end

  context 'Scopes' do
    it 'by_name' do
      market = FactoryBot.create(:markets)
      FactoryBot.create(:markets)
      FactoryBot.create(:markets)
      findMarket = MarketsManagementApi::Models::Market.by_name(market.name)
      expect(findMarket.length).to eq(1)
      expect(findMarket.first.name).to include(market.name)
    end
    it 'by_product_name' do
      markets_products = FactoryBot.create(:markets_products)
      FactoryBot.create(:markets_products)
      FactoryBot.create(:markets_products)
      findProductName = MarketsManagementApi::Models::Market.by_product_name(markets_products.product.name)
      expect(findProductName.length).to eq(1)
      expect(findProductName.first.name).to include(markets_products.market.name)
    end
  end

  context 'Validations' do
    subject { FactoryBot.build(:markets) }
    it { should validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:phone).is_equal_to(10) }
  end
end

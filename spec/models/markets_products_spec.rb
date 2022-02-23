require 'rails_helper'
RSpec.describe MarketsManagementApi::Models::MarketProduct, type: :model do
  context 'Associations' do
    it { should belong_to(:product).inverse_of(:markets_products) }
    it { should belong_to(:market).inverse_of(:markets_products).optional }
  end
end

require 'rails_helper'

RSpec.describe MarketsManagementApi::Models::Product, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:barcode) }

    subject { FactoryBot.build(:products) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  context 'Callbacks' do
    it 'Strip name' do
      product = FactoryBot.build(:products)
      product.name = '     paper  '
      product.save
      expect(product.name).to eq('paper')
    end

    it 'Remove whitespace' do
      product = FactoryBot.build(:products)
      product.barcode = ' 123456789123   4 '
      product.save
      expect(product.barcode).to eq('1234567891234')
    end
  end

  context 'Scopes' do
    it 'by_name' do
      product1 = FactoryBot.create(:products)
      FactoryBot.create(:products)
      FactoryBot.create(:products)

      findProduct = MarketsManagementApi::Models::Product.by_name(product1.name)
      expect(findProduct.length).to eq(1)
      expect(findProduct.first).to eq(product1)
    end
  end

  context 'Associations' do
    it { should have_many(:markets_products).inverse_of(:product) }
  end
end
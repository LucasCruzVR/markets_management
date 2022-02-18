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
  end
end
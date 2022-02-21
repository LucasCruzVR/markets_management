module MarketsManagementApi
  module Concerns
    module Market
      module Associations
        extend ActiveSupport::Concern

        included do
          has_many :markets_products,
                   class_name: 'MarketsManagementApi::Models::MarketProduct',
                   inverse_of: :market

          has_many :products, through: :markets_products, dependent: :destroy
          accepts_nested_attributes_for :markets_products, allow_destroy: true
        end
      end
    end
  end
end

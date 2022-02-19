module MarketsManagementApi
  module Concerns
    module Product
      module Associations
        extend ActiveSupport::Concern

        included do
          has_many :markets_products,
                   class_name: 'MarketsManagementApi::Models::MarketProduct',
                   inverse_of: :product

          has_many :markets, through: :markets_products, dependent: :destroy
        end
      end
    end
  end
end

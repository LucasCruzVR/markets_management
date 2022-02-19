module MarketsManagementApi
  module Concerns
    module MarketProduct
      module Associations
        extend ActiveSupport::Concern

        included do
          belongs_to :market,
                     class_name: 'MarketsManagementApi::Models::Market',
                     inverse_of: :markets_products,
                     optional: true

          belongs_to :product,
                     class_name: 'MarketsManagementApi::Models::Product',
                     inverse_of: :markets_products
        end
      end
    end
  end
end

module MarketsManagementApi
  module Concerns
    module MarketProduct
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :price, presence: true
        end
      end
    end
  end
end

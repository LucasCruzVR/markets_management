module MarketsManagementApi
  module Models
    class MarketProduct < ApplicationRecord
      self.table_name = 'markets_products'

      include MarketsManagementApi::Concerns::MarketProduct::Associations
      include MarketsManagementApi::Concerns::MarketProduct::Callbacks
      include MarketsManagementApi::Concerns::MarketProduct::Methods
      include MarketsManagementApi::Concerns::MarketProduct::Scopes
      include MarketsManagementApi::Concerns::MarketProduct::Validations
    end
  end
end
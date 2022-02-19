module MarketsManagementApi
  module Models
    class Market < ApplicationRecord
      self.table_name = 'markets'

      include MarketsManagementApi::Concerns::Market::Associations
      include MarketsManagementApi::Concerns::Market::Callbacks
      include MarketsManagementApi::Concerns::Market::Methods
      include MarketsManagementApi::Concerns::Market::Scopes
      include MarketsManagementApi::Concerns::Market::Validations
    end
  end
end
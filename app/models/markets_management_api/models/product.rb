module MarketsManagementApi
  module Models
    class Product < ApplicationRecord
      self.table_name = 'products'

      enum category: { Convenience: 0, Shopping: 1, Specialty: 2, Unsought: 3 }

      include MarketsManagementApi::Concerns::Product::Associations
      include MarketsManagementApi::Concerns::Product::Callbacks
      include MarketsManagementApi::Concerns::Product::Methods
      include MarketsManagementApi::Concerns::Product::Scopes
      include MarketsManagementApi::Concerns::Product::Validations
    end
  end
end

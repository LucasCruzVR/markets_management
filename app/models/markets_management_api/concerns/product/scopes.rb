module MarketsManagementApi
  module Concerns
    module Product
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :by_name, lambda { |name|
            where('products.name LIKE ?', "%#{name}%")
          }
        end
      end
    end
  end
end

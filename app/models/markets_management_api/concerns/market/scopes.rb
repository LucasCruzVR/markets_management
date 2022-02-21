module MarketsManagementApi
  module Concerns
    module Market
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :by_name, lambda { |name|
            where('markets.name ILIKE ?', "%#{name}%") if name.present?
          }

          scope :by_product_name, lambda { |product_name|
            joins(:products).merge(MarketsManagementApi::Models::Product.by_name(product_name)) if product_name.present?
          }
        end
      end
    end
  end
end

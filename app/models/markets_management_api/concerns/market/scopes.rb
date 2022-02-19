module MarketsManagementApi
  module Concerns
    module Market
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :by_name, lambda { |name|
            where('name ILIKE ?', "%#{name}%") if name.present?
          }
        end
      end
    end
  end
end

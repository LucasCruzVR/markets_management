module MarketsManagementApi
  module Concerns
    module Product
      module Callbacks
        extend ActiveSupport::Concern

        included do
            before_validation :strip_name
        end

        private
        def strip_name
            self.name = name&.strip
        end
      end
    end
  end
end

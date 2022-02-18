module MarketsManagementApi
  module Concerns
    module Product
      module Callbacks
        extend ActiveSupport::Concern

        included do
          before_validation :strip_name, :remove_whitespace
        end

        private

        def strip_name
          self.name = name&.strip
        end

        def remove_whitespace
          self.barcode = barcode.gsub(/\s+/, '')
        end
      end
    end
  end
end

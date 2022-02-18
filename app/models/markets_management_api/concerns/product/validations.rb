module MarketsManagementApi
  module Concerns
    module Product
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :name, :category, :barcode, presence: true
          validates :name, uniqueness: { case_sensitive: false }
          validates :barcode, length: { is: 13 }, allow_blank: false
        end
      end
    end
  end
end

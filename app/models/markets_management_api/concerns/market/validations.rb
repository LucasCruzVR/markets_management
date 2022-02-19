module MarketsManagementApi
  module Concerns
    module Market
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :name, presence: true
          validates :phone, length: { is: 10 }, allow_blank: false
        end
      end
    end
  end
end

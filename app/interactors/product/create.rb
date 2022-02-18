module Product
  class Create
    include Interactor
    include Interactor::Contracts

    expects do
      required(:product_params).filled
    end

    on_breach do |breaches|
      message = []
      breaches.each do |breach|
        message << breach.messages
      end
      context.fail!(message: message.join(', '))
    end

    def call
      context.product = MarketsManagementApi::Models::Product.new(context.product_params)
      context.fail!(status: 422) unless context.product.save
    end
  end
end

module Product
  class Update
    include Interactor
    include Interactor::Contracts

    expects do
      required(:product_params).filled
      required(:product)
    end

    on_breach do |breaches|
      message = []
      breaches.each do |breach|
        message << breach.messages
      end
      context.fail!(message: message.join(', '))
    end

    def call
      context.product.assign_attributes(context.product_params)
      context.fail!(status: 422) unless context.product.save
    end
  end
end

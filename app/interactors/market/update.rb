module Market
  class Update
    include Interactor
    include Interactor::Contracts

    expects do
      required(:market_params).filled
      required(:market)
    end

    on_breach do |breaches|
      message = []
      breaches.each do |breach|
        message << breach.messages
      end
      context.fail!(message: message.join(', '))
    end

    def call
      context.market.assign_attributes(context.market_params)
      context.fail!(status: 422) unless context.market.save
    end
  end
end

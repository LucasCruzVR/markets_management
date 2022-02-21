module Market
  class Create
    include Interactor
    include Interactor::Contracts

    expects do
      required(:market_params).filled
    end

    on_breach do |breaches|
      message = []
      breaches.each do |breach|
        message << breach.messages
      end
      context.fail!(message: message.join(', '))
    end

    def call
      context.market = MarketsManagementApi::Models::Market.new(context.market_params)
      context.fail!(status: 422) unless context.market.save
    end
  end
end

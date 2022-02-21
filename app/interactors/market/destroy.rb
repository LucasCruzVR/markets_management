module Market
  class Destroy
    include Interactor
    include Interactor::Contracts

    expects do
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
      context.fail!(status: 422) unless context.market.destroy
    end
  end
end

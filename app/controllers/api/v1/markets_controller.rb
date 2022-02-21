module Api
  module V1
    class MarketsController < ApplicationController
      before_action :set_market, only: %i[show update destroy]
      def index
        @markets = MarketsManagementApi::Models::Market.by_name(params[:name])
                                                       .by_product_name(params[:product_name])
                                                       .order(name: :asc)
      end

      def show; end

      def create
        context = Market::Create.call(market_params: market_params)
        @market = context.market
        if context.success?
          render :show, status: :created
        else
          render json: formatError(context, :market), status: context.status | 400
        end
      end

      def update
        context = Market::Update.call(market_params: market_params,
                                      market: @market)
        @market = context.market
        if context.success?
          render :show, status: :ok
        else
          render json: formatError(context, :market), status: context.status | 400
        end
      end

      def destroy
        context = Market::Destroy.call(market: @market)
        if context.success?
          head :ok
        else
          render json: formatError(context, :market), status: context.status | 400
        end
      end

      private

      def set_market
        @market = MarketsManagementApi::Models::Market.find(params[:id])
      end

      def market_params
        params.permit(:id, :name, :phone, :address, :_destroy,
                      markets_products_attributes: %i[id product_id market_id price])
      end
    end
  end
end

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: %i[show update destroy]
      def index
        @products = MarketsManagementApi::Models::Product.by_name(params[:name])
                                                         .order(name: :asc)
      end

      def create
        context = Product::Create.call(product_params: product_params)
        @product = context.product
        if context.success?
          render :show, status: :created
        else
          render json: formatError(context, :product), status: context.status
        end
      end

      def update
        context = Product::Update.call(product_params: product_params,
                                       product: @product)
        @product = context.product
        if context.success?
          render :show, status: :ok
        else
          render json: formatError(context, :product), status: context.status
        end
      end

      def destroy
        context = Product::Destroy.call(product: @product)
        if context.success?
          head :ok
        else
          render json: formatError(context, :product), status: context.status
        end
      end

      private

      def set_product
        @product = MarketsManagementApi::Models::Product.find(params[:id])
      end

      def product_params
        params.permit(:id, :name, :category, :barcode)
      end
    end
  end
end

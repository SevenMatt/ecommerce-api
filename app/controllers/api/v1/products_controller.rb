module Api
    module V1
        class Api::V1::ProductsController < ApplicationController
        before_action :set_production, only: %i[show update destroy]

    def index
        @products = Product.all
        render json: @products
    end

    def show
        render json: @Product
    end 

    def create
        @product = Product.new(product_params)
        if @product.save
            render json: @product, status: :created
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    def update
        if @product.update(product_params)
            render json: @product
        else
            render json: @product.errors, status: : unprocessable_entity
        end
    end

    def destroy
        @product.destroy
        head :no_content
    end


    private

    def set_production
        @product = Product.find(params[:id])
    end

    def product_params 
        params.require(:product).permit(:name, :description, :price, :stock_quantity)
    end
  end
end



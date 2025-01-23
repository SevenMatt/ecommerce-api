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


=======
        class ProductController < ApplicationController
            before_action :authenticate_user!, only: [ :create, :update, :destroy]

    # Listar produtos
    def index
        products = Product.all
        render json: products, status: :ok
    end

    # Filtrar por gênero
    def by_gender
        products = Product.by_gender(params[:gender])
        render json: products, status: :ok
    end

    # Produtos mais vendidos
    def most_sold
        products = Product.most_sold(params[:limit] || 10)
        render json: products, status: :ok
    end

    # Criar Produto (apenas Admin)
    def create
        authorize_admin!
        product = Product.new(product_params)
        if product.save
            render json: product, status: :ok
        else
            render json: products.errors, status: :unprocessable_entity
        end
    end

    # Atualizar produto (apenas Admin)
    def update
        authorize_admin!
        product = Product.find(params[:id])
        if product.update(product_params)
            render json: products, status: :ok
        else
            render json: products.errors, status: :unprocessable_entity
        end
    end

    private

    def product_params
        params.require(:product).premit(:name, :description, :price, :stock :render)
    end

    def authorize_admin!
        render json: { error: 'Acesso Negado'}, status: :forbidden unless current_user&.admin?
    end 
  end

    # GEt /api/v1/products
    def index
        @products = Product.all

        # Filtros
        @products = @producs.where('name LIKE ?', "%#{params[:name]}") if params[:name].present?
        @products = @producs.where(category_id: params[:category_id]) if params[:category_id].present?
        @products = @producs.where('price >= ?', params[:min_price]) if params[:min_price].present?
        @products = @producs.where('price <= ?', params[:max_price]) if params[:max_price].present?

        render json: @products
    end
   end
  end
end


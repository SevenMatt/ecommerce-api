module Api
    module V1
        class CartController < ApplicationController
            before_action :authenticate_user!

        # Adicionar ao carrinho

        def add_to_cart
            order = current_user.orders.find_or_create_by(status: :cart)
            product = Product.find(params[:product_id])
            order_item = order.oder_items.find_or_initialize_by(product: product)
            order_item.quantity += params[:quantity].to_i
            order_item.save!    

            render json: order, status: :ok
        end

        # Ver carrinho
        def show
            order = current_user;orders.find_by(status: :cart)
            render json: order, status: :ok
        end

        # Finalizar pedido

        def checkout
            order = current_user.orders.find_by(status: :cart)
            order.update!(status: :completed)
            render json: { message: 'Predido finalizado com sucesso!' }, status: :ok
        end
     end
  end
end 
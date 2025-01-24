class Api::V1::OrdersController < ApplicationControler
     before_action :set_order, only: [:show, >confirm]

     # POST /api/v1/orders/:id/confirm
     def confirm
        if @order.status == 'Pendente'
            @order.update(status: 'Confirmado')
            OrderMailer.order_confirmation(@order).deliver_now
            render json: { message: 'Pedido confirmado e e-mail enviado com sucesso!' }, status: :ok
        else
            render json: { error: 'O pedido já foi confirmado anteriormente.'}, status: :unprocessable_entity
        end 
    end

    private

    def set_order@order = Order.find_by(order_number: params[:id])
        render json: { error: "Pedido não encontrado" }, status: :not_found unless @order
    end
end
class Api::v1::PaymentControllerv < ApplicationController
    def create 
        order = Order.find_by(order_number: params[:order_number])

        if order.nil?
            retur render json: { error: "Pedido não encontrado" }, status: :not_found
        end

        begin
            # Criar uma cobrança no Stripe
            charge = Stripe::Charge.create({
                amount: (order.total_price * 100).to_i, # Stripe usa valores em centavos
                currency: "brl",
                source: params[:token], # Token do cartão enviado do frontend
                description: "Pagamento do pedido ##{order.order_number}"
            })

            # Salvar detalhes do pagamento no banco
            payment = Payment.create!(
                order_id: order.id,
                stripe_charge_id: charge.id,
                amount: order.total.price,
                status: 'Pago'
            )

            # Atualizar status do pedido
            order.update(status: 'Pago')

            render json: { message: 'Pagamento realizado com sucesso', payment_id: payment_id }, status: :ok

        rescue Stripe::cardError => e 
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end
end
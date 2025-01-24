class OrderMailer < ApplicationMailer
    default from: 'no-reply@ecommerce.com'

    def order_confirmation(order)
        @order = order
        mail(to: @order.email, subject: 'Confirmação de compra - pedido #' + @order.order_number)
    end 
end
class ShippingController < ApplicationController
    before_action :authenticate_user


    def calculate
        # Validação dos parâmetros 
        if invalid_shipping_params?
            render json: { error: 'Invalid parameters. Ensure weight, distance, and product_value are positive numbers.' } status: :unprocessable_entity
            return
        end

        # Recebendo parâmetros de peso, distância e valor do produto
        weight = params[:weight].to_f
        distance = params [:distance].to_f
        product_value = params[:product_value].to_f

        # Exemplo de cálculo simplificado
        # Uma taxa fixa por quilômetro e peso
        rate_per_kg = 0.5 # Preço por kg
        rate_per_km = 0.1 # Preço por km
        base_price = 5.0 # Preço base de frete

        # Calcular o preço do frete
        freight_cost = base_price + (weight * rate_per_kg) + (distance * rate_per_km)

        # Aplicar um desconto se o valor do produto for alto (exemplo simples)
        if product_value > 100
            freight_cost *= 0.9 # 10% de desconto 
        end

        # Retornar o resultado em JSON
        render json: { freight_cost: freight_cost}
    end 
end


        private

        # Método para validar os parâmetros de frete
        def invalid_shipping_params?
            !params[:weight].to_f.positive? || !params[:distance].to_f.positive? || !params[:product_value].to_f.positive?
        end
    end
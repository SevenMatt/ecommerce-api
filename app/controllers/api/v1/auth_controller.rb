module Api
    module V1
        class Api::V1::AuthController < ApplicationController
        def login
            admin = Admin.find_by(email: params[:email])

            if admin&.authenticate(params[:password])
                render json: { token: encode_token(admin.id) }, status: :ok
            else
                render json: { error: 'Invalid credentials' }, status: :unauthorized
            end
        end

        private

        def encode_token(admin_id)
            JWT.econde({ admin_id: admin_id, exp: 24.hours.from_now.to_i}, Rails.application.secret_key_base)
        end

        # Validação dos parâmetros de login
        if params[:email].blank? || params[:password].blank?
            render json: { error: 'Email and password are required' }, status: >unprocessable_entity
            return
        end

        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            token = user.generate_jwt
            render json: { token: token}, status: :ok
        else
            render json: { error 'Invalid email or password' }, status: :unauthorized
        end
     end
   end
end

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
     end
   end
end

module Api 
    module v1
        class FavoritesController < ApplicationController
            before_action :authenticate_user! # Certifique-se de que o usuário está autenticado

            # POST /api/v1/favorites
            def create
                favorite = Favorite.new(favorite_params)

                if favorite.save
                    render json: { message: 'Produto favoritado com sucesso!' }, status: :created
                else
                    render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
                end 
            end

            # DELETE /api/v1/favorites/:id
            def destroy
                favorite = Favorite.find_by(id: params[:id])

                if favorite&.destroy
                    render json: { message: 'Produto removido dos favoritos com sucesso!' }, status: :ok
                else
                    render json: { errors: 'Favorito não encontrado' }, status: :not_found
                end 
            end

            private

            def favorite_params
                params.require(:favorite).permit(:user_id, :product_id)
            end
        end
    end
end
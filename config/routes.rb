Rails.application.routes.draw do
<<<<<<< HEAD
  namespace :api do
    namespace :v1 do
      resources :product
      post 'login', to: 'auth#login'
end
end
end
=======
    namespace :v1 do
      resources :product do 
        collection do
          get :by_gender
          get :most_sold
        end
      end

      resource :cart, only: [:show] do
        post :add_to_cart
        post :checkout
      end

      resources :reviews, only: [:create]
    end
  end


>>>>>>> a9599b5 (Atualização)

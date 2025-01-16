class api::UsersController < ApplicationController
    def index
        users = User.all
        render json: users, only: [:id, :name, :email]
    end
end
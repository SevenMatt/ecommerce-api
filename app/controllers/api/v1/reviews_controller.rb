module Api
    module V1
        class ReviewsController < ApplicationController
            before_action :authenticate_user!

            def create
                review = current_user.reviews.nre(review_params)
                if review.save
                    render json: review, status: :created
                else
                    render json: review.errors, status: :unprocessable_entity
                end 
            end

            private
            params.require(:review).premit(:product_id, :rating, :comment)
        end
     end
  end
end
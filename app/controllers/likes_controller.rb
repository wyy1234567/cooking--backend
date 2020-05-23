class LikesController < ApplicationController
    # create
    # delete

    def create
        like = Like.create(like_params)
        render json: like, except: [:created_at, :updated_at]
    end

    def destroy 
        like = Like.find(params[:id])
        like.destroy
    end

    private
    def like_params
        params.require(:like).permit(:user_id, :recipe_id)
    end
end

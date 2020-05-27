class FollowsController < ApplicationController

    def index 
        follows = Follow.all
        render json: follows
    end
    
    def add_follow
        follow = Follow.create(follow_params)
        render json: follow
    end

    def destroy 
        follow = Follow.find(params[:id])
        follow.destroy
    end

    private
    def follow_params
        params.require(:follow).permit(:user_id, :following_id)
    end
end

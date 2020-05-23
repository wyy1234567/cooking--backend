class UsersController < ApplicationController
    ### very simple for now, we'll do this for real later
    # register
    # login

    def register 
        user = User.create(user_params)
        render json: user, except: [:created_at, :updated_at]
    end
    
    def login
        user = User.find(params[:id])
        render json: user, except: [:created_at, :updated_at]
    end

    private
    def user_params
        params.require(:user).permit(:name, :password_digest)
    end
end

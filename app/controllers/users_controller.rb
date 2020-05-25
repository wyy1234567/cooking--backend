class UsersController < ApplicationController
    ### very simple for now, we'll do this for real later
    # register
    # login

    skip_before_action :authorized

    def index
        render json: User.all 
    end

    def register 
        # user = User.create(user_params)
        # set_user(user)
        # render json: user, except: [:created_at, :updated_at]

        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { id: user.id, name: user.name, jwt: token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end
    
    def login
        # user = User.find_by(name: user_params[:name])
        # set_user(user)
        # render json: user, except: [:created_at, :updated_at]

        user = User.find_by(name: user_params[:name])
        #User#authenticate comes from BCrypt

        puts "FOUND USER?"
        puts user

        up = user_params
        puts up[:password_digest]

        if user && user.authenticate(up[:password])
            # encode token comes from ApplicationController
            puts "AUTHENTICATED"
            token = encode_token({ user_id: user.id })
            render json: { id: user.id, name: user.name, jwt: token }, status: :accepted
        else
            puts "NOT AUTHENTICATED"
            render json: { message: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def logout
        # set_user(nil)
        #
        # hmm, is there a way to invalidate the token?
        #
    end

    private
    def user_params
        puts params
        params.require(:user).permit(:name, :password)
    end
end

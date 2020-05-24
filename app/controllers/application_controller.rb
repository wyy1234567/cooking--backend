class ApplicationController < ActionController::API
    before_action :authorized

    # def current_user
    #     session[:user]
    # end

    # def set_user(user)
    #     puts "setting user"
    #     puts user
    #     if user then
    #         session[:user] = user
    #         puts "WE should have a user in session"
    #         puts session[:user]
    #     else
    #         puts "NO USER HERE"
    #         session.delete(:user)
    #     end
    # end

    def encode_token(payload)
        # payload => { beef: 'steak' }
        JWT.encode(payload, secret)
        # jwt string: "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
    end

    def secret
        '!ejwYBn67hu^r567$'
    end
    
    def auth_header
        puts "headers?"
        puts request.headers
        puts request.headers['Authorization']
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
    end
    
    def decoded_token
        puts "decode token"
        if auth_header
            puts "we have an auth header"
            puts auth_header
            token = auth_header.split(' ')[1]
            puts token
            # headers: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, secret, true, algorithm: 'HS256')
                # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        decoded = decoded_token
        if decoded
            # decoded_token=> [{"user_id"=>2}, {"alg"=>"HS256"}]
            # or nil if we can't decode the token
            user_id = decoded[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end


class SessionsController < ApplicationController
    # skip_before_action :authorized, only: [:create]
    before_action :logged_in?, only: [:login]

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            login!
            token = encode_token({ user_id: @user.id })
            render json: {
                jwt: token,
                user: @user
            },
            status: :accepted
        else
            render json: {
                status: 401,
                errors: ['Username or Password is invalid']
            }
        end
    end

    def login 
        binding.pry
        if logged_in? && current_user
            render json: {
                isLoggedIn: true,
                message: 'Created User',
                user: current_user
            }
        else
            render json: {
                isLoggedIn: false,
                message: 'Not logged in'
            }
        end
    end



    def googleAuth
        # Get access tokens from the google server
        access_token = request.env["omniauth.auth"]
        user = User.from_omniauth(access_token)
        log_in(user)
        # Access_token is used to authenticate request made from the rails application to the google server
        user.google_token = access_token.credentials.token
        # Refresh_token to request new access_token
        # Note: Refresh_token is only sent once during the first request
        refresh_token = access_token.credentials.refresh_token
        user.google_refresh_token = refresh_token if refresh_token.present?
        user.save
        redirect_to root_path
    end


    private

    def session_params
        params.require(:user).permit(:username, :password)
    end

end
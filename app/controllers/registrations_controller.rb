class RegistrationsController < ApplicationController


    def create
        user = User.create!(
            username: params['user']['username'],
            password: params['user']['password'],
            password_confirmation: params['user']['password_confirmation'],
            image: params['user']['image']
        )
        if user
            session[:user_id] = user.id
            render json: {
                user: user,
                logged_in: true, 
                status: :created
            }
        else
            render json: { status: 500 }
        end
    end
end
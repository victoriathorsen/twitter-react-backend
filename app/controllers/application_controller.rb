class ApplicationController < ActionController::Base
      include ActionController::Cookies
      include ActionController::RequestForgeryProtection
  
      skip_before_action :verify_authenticity_token
      helper_method :login!, :logged_in?, :current_user, :authorized, :logout!, :set_user
  
  #     before_action :authorized 
  
      def encode_token(payload)
        # should store secret in env variable
        JWT.encode(payload, 'my_s3cr3t')
      end
    
      def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
      end
    
      def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
    
          # header: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
      end
          
      def current_user
        if decoded_token
              user_id = decoded_token[0]['user_id']
              @user = User.find_by(id: user_id)
            end
      end
      
      def login!
            session[:user_id] = @user.id
      end
  
      def logged_in?
              !!session[:user_id]
      end
  
  
      def authorized
              unless logged_in?
                    render json: { message: 'Please log in' }, status: :unauthorized
              end
      end
  
      def logout!
             session.clear
      end
  
      def set_user
          @user = User.find_by(id: session[:user_id])
      end
  
  end
class ApplicationController < ActionController::Base
    helper_method :current_user
    # Protect for SCRF Attacks
    protect_from_forgery with: :exception


    # login functionality is to prevent from many logins to the same user session and she protect that by called a function in the user model that 
    # reset the current_session_token 
    def login!(user)
        # force other clients to log out by regenerating a new session token
        user.reset_session_token!
        # log in this client
        @current_user = user
        session[:session_token] = user.session_token
    end

    # destroy methdod for loging out
    def logout!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
    end

    # fetches the user who login in
    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(:session_token => session[:session_token])
    end
end

class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials!(
            params[:users][:email],
            params[:users][:password]
        )

        if user.nil?
            render :json => "Credentials are wrong"
        else
            login!(user)
            redirect_to user_path(user)
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end

    def new
        render :new
    end
end

class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials!(
            params[:users][:email],
            params[:users][:password]
        )

        if user.nil?
            redirect_to :new_session, alert: "User not Found"
        else
            login!(user)
            redirect_to cats_url
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
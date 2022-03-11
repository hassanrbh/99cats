class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials!(
            :email => params[:users][:email],
            :password => params[:users][:password]
        )

        if user.nil?
            render :json => "Credentials are wrong"
        else
            redirect_to user_path(user)
        end
    end

    def new
        render :new
    end
end

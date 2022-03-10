class SessionsController < ApplicationController
    def create
        # search for the user
        user = User.find_by_credentials(
            params[:users][:email],
            params[:users][:password]
        )
        
        if user.nil?
            render json: "Credentials Were wrong"
        else
            login!(user)
            redirect_to user_path(user)
        end
    end
    def new
        @user = User.new
        render :new
    end
end

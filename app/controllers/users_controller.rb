class UsersController < ApplicationController
  # before action for the user to not see the users#show before log in
  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_path(@user)
    else
      render :json => @user.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def new
    @user = User.new # for some user who are just creating an account
    render :new
  end

  def show
    if current_user.nil?
      redirect_to new_session_path
      return 
    end
    @user = current_user
    render :show
  end
  private

  def user_params
    params.require(:users).permit(:email,:password)
  end

end

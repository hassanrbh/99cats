class UsersController < ApplicationController
  before_action :already_logged_in?, only: [:new, :create]
  # before action for the user to not see the users#show before log in
  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      redirect_to :new_session, success: "User already Exist"
    end
  end

  def new
    @user = User.new # for some user who are just creating an account
    render :new
  end

  def show
    if current_user.nil?
      redirect_to new_user_path
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

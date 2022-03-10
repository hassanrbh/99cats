class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render :json => @user.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def new
    @user = User.new # for some user who are just creating an account
    render :new
  end

  def show
    @user = User.find_by(:id => params[:id])

    if @user
      render :show
    else
      redirect_to cats_url
    end
  end

  private

  def user_params
    params.require(:users).permit(:email,:password)
  end

end

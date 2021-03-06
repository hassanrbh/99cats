# frozen_string_literal: true

class CatsController < ApplicationController
  before_action :owns_cat?, only: %i[edit update]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    if current_user.nil?
      redirect_to signin_url
      return
    end
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    if current_user.nil?
      redirect_to signin_url
      return
    end
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cats_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
    if current_user.nil?
      redirect_to signin_url
      return
    end
    @cat = current_user.cats.find_by(id: params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find_by(id: params[:id])
    if @cat.update(cats_params)
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: :unprocessable
    end
  end

  protected

  def cats_params
    params.require(:cats).permit(:name, :color, :sex, :description, :birth_date, :user_id)
  end
end

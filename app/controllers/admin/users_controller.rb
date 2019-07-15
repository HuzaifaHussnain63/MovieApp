class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user, only: [:destroy, :edit, :update]

  def index
    @users = User.order(:name).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Successfully created a new user'
    else
      flash[:danger] = 'Could not create a new user'
    end

    redirect_to admin_users_path
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updates user's details."
      redirect_to admin_users_path
    else
      flash[:danger] = 'Something went wrong. Try Again.'
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User Successfully removed.'
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :avatar)
  end
end

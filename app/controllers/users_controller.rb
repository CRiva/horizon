class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def edit
  end

  def update
    # @user.update(params)
    @user.role_ids = params[:user][:role_ids]
    # render text: user_params.inspect
    redirect_to users_path
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role_ids)
  end
end

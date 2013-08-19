class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def edit
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email :body)
  end
end

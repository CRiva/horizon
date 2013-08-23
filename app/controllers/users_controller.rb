class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.role_ids = params[:user][:role_ids]
        @user.page = params[:page]
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    # @user.update(user_params)
    # @user.role_ids = params[:user][:role_ids]
    # @user.page = params[:user][:page]
    # render text: user_params.inspect
    # redirect_to users_path
  end

  def destroy
    @user.destroy
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role_ids, :page) # try user:{:role_ids} when everyting else is working.
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    # load the unpublished article for a particular page.
    @unpub_articles = Article.where(page: current_user.page, published: false)
    @new_articles = Article.where(aasm_state: 'new', published: false).order("articles.page ASC")
    @my_articles  = Article.where(author_id: current_user)
    @my_comments = Comment.where(name: current_user.name)
    # @pub_articles = Article.where(page: current_user.page, published: true)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update # TODO shorten this.
    respond_to do |format|
      if @user.update(user_params)
        @user.name = params[:user][:name]
        @user.role_ids = params[:user][:role_ids]
        @user.page = params[:user][:page]
        if @user.role_ids == []
          @user.role_ids = [3] # to default to member if no id
        end
        @user.save
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
    respond_to do |format|
      format.html { redirect_to users_url, notice: "user was successfully deleted."}
      format.json { head :no_content }
    end
  end


  private
  # share some functionality
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    f = params.require(:user).permit(:name, :email, :role_ids, :page) # try user:{:role_ids} when everyting else is working.
    puts f.inspect
  end
end

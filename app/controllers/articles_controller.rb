# controller responsible for showing articles to the user
class ArticlesController < ApplicationController
  # impressionist :actions=>[:show]

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @articles =
      if params[:search].nil?
        Article.published.
          on(params[:page_id]).
          order(created_at: :desc).
          page(params[:page]).per(10)
      else
        Article.search(params[:search])
      end
  end

  def show
    impressionist(@article)
    @comment = Comment.new(article: @article)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.author_name = article_params[:author_name]
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update_attributes(article_params)
        @article.author_name = article_params[:author_name]
        @article.save
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    # delete a specific article.
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,
                                    :body,
                                    :photo,
                                    :pdf,
                                    :page,
                                    :published,
                                    :author_id,
                                    :author_name,
                                    :due_date)
  end
end

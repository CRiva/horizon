class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    # get the articles for that page (i.e. news, sports)
    section_articles = Article.published.where(page: params[:page_id])
    @articles = section_articles.page(params[:page]).per(10)
    # do different formatting.
    respond_to do |format|
      format.html # index.hmtl.haml
      format.xml { render xml: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show # make a new comment to show at the bottom of the page.
    @comment = Comment.new(article: @article)
  end

  # GET /articles/new
  def new # make a new article for the new form
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end # article is already chosen in the set_article private function

  # POST /articles
  # POST /articles.json
  def create
    # saves article created in new form
    #  article_params[:author_name] = User.find(article_params[:author_id])
    puts "==========================================================="
    puts article_params.inspect
    puts "==========================================================="
    @article = Article.new()
    @article.title = article_params[:title]
    @article.body  = article_params[:body]
    @article.author_id = article_params[:author_id]
    @article.author_name = User.find(article_params[:author_id]).name
    @article.published = article_params[:published]
    @article.page = article_params[:page]

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

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    # same as new, just with a article that already existed.
    @article.title = article_params[:title]
    @article.body  = article_params[:body]
    @article.author_id = article_params[:author_id]
    @article.author_name = User.find(article_params[:author_id]).name
    @article.published = article_params[:published]
    @article.page = article_params[:page]

    respond_to do |format|
      if @article.save

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
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :photo, :page, :published, :author_id, :author_name, :due_date)
    end
end

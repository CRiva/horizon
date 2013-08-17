class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to(@article, notice: 'Comment was successfully created.')}
        format.xml {render xml: @article, status: :created, location: @article }
      else
        format.html { redirect_to(@article, notice: 'Comment could not be saved. Try again.')}
        format.xml { render xml: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

=begin
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
=end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @article = @comment.article
    respond_to do |format|
      if @coment.update_attributes(params[:comment])
        format.html { redirect_to(@article, notice: 'Comment was successfully update.')}
        format.xml { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml { render xml: @comment.errors, status: :upprocessable_entity}
      end
    end
  end
=begin
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
    @comment.destroy

    respond to do |format|
      format.html { redirect_to(@article, notice: 'Comment was successfully deleted.')}
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:article_id, :name, :body)
    end
end

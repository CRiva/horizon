class VisitorsController < ApplicationController

  def new
    # just load articles for the home page.
    @slides = Article.where("photo_file_name !=?", "/photos/original/missing.png").reverse.take(3)
    @articles = Article.published.order('created_at DESC').page(params[:page]).per(15)
  end

end

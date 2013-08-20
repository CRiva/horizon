class VisitorsController < ApplicationController

  def new
    @slides = Article.where("photo_file_name !=?", "/photos/original/missing.png").reverse.take(3)
    @articles = Article.published
  end

end

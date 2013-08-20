class VisitorsController < ApplicationController

  def new
    @slides = []
    @articles = Article.news
  end

end

class VisitorsController < ApplicationController

  def new
    @slides = []
    @articles = Article.all
  end

end

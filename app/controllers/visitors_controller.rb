class VisitorsController < ApplicationController

  def new
    @articles = Article.all
  end

end

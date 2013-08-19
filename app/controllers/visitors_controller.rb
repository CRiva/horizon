class VisitorsController < ApplicationController

  def new
    @slides = Article.find(:all, order: "id desc", limit: 3).reverse
    @articles = Article.all
  end

end

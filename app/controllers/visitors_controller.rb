class VisitorsController < ApplicationController
  impressionist
  def new
    # just load articles for the home page.
    @articles = Article.published.order('created_at DESC').page(params[:page]).per(15)
  end

end

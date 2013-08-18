class RolesController < ApplicationController
  def index
    @users = User.all
  end

  def edit
  end
end

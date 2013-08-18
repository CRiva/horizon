class RolesController < ApplicationController
  def index
    @users = User.all
  end
end

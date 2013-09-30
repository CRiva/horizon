class RolesController < ApplicationController
  # most interactions with roles are done through user.
  def index
    @users = User.all
  end

  def edit
  end
end

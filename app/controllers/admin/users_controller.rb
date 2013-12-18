class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  can_access :owner
  lock_down!

  def index
    @users = User.all
  end
end

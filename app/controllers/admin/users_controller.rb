class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  can_access :owner
  lock_down!

  def index
    @users = User.all
  end

  def new
  end

  def create
    user = User.new(user_params)
    user.role = :artist
    user.save!
    redirect_to action: :index
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end
end

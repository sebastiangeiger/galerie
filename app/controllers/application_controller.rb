class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def self.can_access(role)
    @allowed_roles ||= RoleCollection.new
    @allowed_roles << role
  end
  def self.lock_down!
    allowed_roles = @allowed_roles.dup
    the_proc = Proc.new do
      unless current_user and allowed_roles.allow?(current_user.role)
        redirect_to root_path
      end
    end
    self.class_exec do
      before_filter the_proc
    end
  end
end

class RoleCollection
  def initialize
    @roles = []
  end
  def <<(role)
    @roles << role
  end
  def allow?(role)
    @roles.map(&:to_sym).include?(role.to_sym)
  end
end

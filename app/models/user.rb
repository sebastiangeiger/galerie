class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  def role
    role = read_attribute(:role)
    role.to_sym if role
  end

  # AlLow creating users without passwords
  def password_required?
    if confirmed?
      super
    else
      false
    end
  end
end

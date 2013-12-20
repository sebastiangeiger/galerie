class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  def role
    role = read_attribute(:role)
    role.to_sym if role
  end

  # Allow creating users without passwords
  def password_required?
    if confirmed?
      super
    else
      false
    end
  end

  def confirmation_status
    confirmed? ? :confirmed : :not_confirmed
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def self.find_by_public_confirmation_token(public_confirmation_token)
     confirmation_token = Devise.token_generator.digest(self, :confirmation_token, public_confirmation_token)
     find_by_confirmation_token(confirmation_token)
  end
end

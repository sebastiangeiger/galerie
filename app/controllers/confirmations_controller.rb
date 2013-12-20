class ConfirmationsController < Devise::ConfirmationsController
  before_filter :require_not_signed_in

  def show
    self.resource = resource_class.find_by_public_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    if resource.nil? or resource.confirmed?
      super
    end
  end

  def confirm
    self.resource = resource_class.find_by_public_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    if resource.update_attributes(params[resource_name].except(:confirmation_token).permit(:password, :password_confirmation)) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
end

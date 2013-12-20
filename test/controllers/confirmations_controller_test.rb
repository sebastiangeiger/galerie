require "test_helper"

describe ConfirmationsController do
  describe "GET show" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
    describe "Authentication" do
      it "denies a logged in user" do
        sign_in FactoryGirl.create(:user)
        get :show
        response.must_be :redirect?
        flash[:alert].must_equal "You cannot be signed in for this."
      end
      it "lets a signed out user in" do
        get :show
        response.must_be :success?
      end
    end
  end
end

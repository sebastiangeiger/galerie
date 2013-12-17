require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "anonymous user should get redirected to sign in form" do
    get :index
    assert_response :redirect
  end

  test "logged in user should get index" do
    sign_in FactoryGirl.create(:user)
    get :index
    assert_response :success
  end
end

require 'test_helper'

describe AdminController, "Authentication" do
  it "denies anonymous users" do
    get :index
    response.must_be :redirect?
    response.redirect_url.must_match /\/users\/sign_in$/
  end

  it "lets signed in users through" do
    sign_in FactoryGirl.create(:user)
    get :index
    response.must_be :success?
  end
end

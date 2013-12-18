require "test_helper"

describe Admin::UsersController, "Authentication" do
  it "denies anonymous users" do
    get :index
    response.must_be :redirect?
    response.redirect_url.must_match /\/users\/sign_in$/
  end

  it "denies signed in artist" do
    sign_in FactoryGirl.create(:artist)
    get :index
    response.must_be :redirect?
  end

  it "lets signed in owner through" do
    sign_in FactoryGirl.create(:owner)
    get :index
    response.must_be :success?
  end
end

describe Admin::UsersController, "Logic" do
  before do
    sign_in FactoryGirl.create(:owner)
  end

  it "assigns @users" do
    get :index
    assigns(:users).size.must_equal 1
  end
end

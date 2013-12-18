require "test_helper"

describe Admin::UsersController do
  describe "GET index" do
    describe "Authentication" do
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

    describe "Logic" do
      before do
        sign_in FactoryGirl.create(:owner)
      end

      it "assigns @users" do
        get :index
        assigns(:users).size.must_equal 1
      end
    end
  end

  describe "GET new" do
    describe "Authentication" do
      it "denies anonymous users" do
        get :new
        response.must_be :redirect?
        response.redirect_url.must_match /\/users\/sign_in$/
      end

      it "denies signed in artist" do
        sign_in FactoryGirl.create(:artist)
        get :new
        response.must_be :redirect?
      end

      it "lets signed in owner through" do
        sign_in FactoryGirl.create(:owner)
        get :new
        response.must_be :success?
      end
    end
  end

  describe "POST create" do
    describe "Authentication" do
      it "denies anonymous users" do
        post :create, user: {email: "email@example.com"}
        response.must_be :redirect?
        response.redirect_url.must_match /\/users\/sign_in$/
      end

      it "denies signed in artist" do
        sign_in FactoryGirl.create(:artist)
        post :create, user: {email: "email@example.com"}
        response.must_be :redirect?
      end

      # it "lets signed in owner through" do
      #   sign_in FactoryGirl.create(:owner)
      #   post :create, user: {email: "email@example.com"}
      #   response.must_be :success?
      # end
    end

    describe "Logic" do
      before do
        sign_in FactoryGirl.create(:owner)
      end
      it "creates a user" do
        User.where(email: "email@example.com").count.must_equal 0
        post :create, user: {email: "email@example.com"}
        User.where(email: "email@example.com").count.must_equal 1
      end
      it "the user has an artist role" do
        post :create, user: {email: "email@example.com"}
        User.where(email: "email@example.com").first.role.must_equal :artist
      end
    end
  end
end

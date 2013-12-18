require 'test_helper'

describe User, "Factory" do
  it "has a name" do
    FactoryGirl.create(:user).name.wont_be :blank?
  end
  it "is confirmed" do
    FactoryGirl.create(:user).must_be :confirmed?
  end
  describe "regular user" do
    it "has a role" do
      FactoryGirl.create(:user).role.must_equal :user
    end
  end
  describe "artist" do
    it "has a role" do
      FactoryGirl.create(:artist).role.must_equal :artist
    end
  end
  describe "owner" do
    it "has a role" do
      FactoryGirl.create(:owner).role.must_equal :owner
    end
  end
end

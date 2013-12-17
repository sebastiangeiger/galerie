require 'test_helper'

describe User, "Factory" do
  it "has a name" do
    FactoryGirl.create(:user).name.wont_be :blank?
  end
end

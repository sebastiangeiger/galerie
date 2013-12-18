Given(/^I am not signed in$/) do
  visit '/users/sign_out'
end

Given(/^I am signed in as an owner$/) do
  @user = FactoryGirl.create(:owner)
  sign_in_with(@user.email, @user.password)
end

Given(/^I have the account "(.*?)" with the password "(.*?)"$/) do |email, password|
  FactoryGirl.create(:user, email: email, password: password)
end

When(/^I sign in with "(.*?)"\/"(.*?)"$/) do |email, password|
  sign_in_with(email, password)
end

def sign_in_with(email, password)
  visit '/users/sign_in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_on "Sign in"
end

Then(/^I should be able to access the admin page$/) do
  visit '/admin'
  page.has_content?("Admin#index").must_equal true
end

When(/^I go to the user management page$/) do
  visit '/admin/users'
end

Then(/^I should see (\d+) user$/) do |size|
  page.all('table#users tbody tr').size.must_equal size.to_i
end

Then(/^I should see my email address$/) do
  @user.wont_be_nil
  @user.email.wont_be :blank?
  within('table#users') do
    page.has_content?(@user.email).must_equal true
  end
end

Then(/^I should see my name$/) do
  @user.wont_be_nil
  @user.name.wont_be :blank?
  within('table#users') do
    page.has_content?(@user.name).must_equal true
  end
end

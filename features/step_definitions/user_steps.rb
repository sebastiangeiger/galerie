Given(/^I am not signed in$/) do
  visit '/users/sign_out'
end

Given(/^I have the account "(.*?)" with the password "(.*?)"$/) do |email, password|
  FactoryGirl.create(:user, email: email, password: password)
end

When(/^I sign in with "(.*?)"\/"(.*?)"$/) do |email, password|
  visit '/users/sign_in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_on "Sign in"
end

Then(/^I should be able to access the admin page$/) do
  visit '/admin'
  assert page.has_content?("Admin#index")
end

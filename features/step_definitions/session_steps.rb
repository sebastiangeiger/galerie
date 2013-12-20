When(/^(?:|I )sign out$/) do
  visit '/users/sign_out'
end

Given(/^I am not signed in$/) do
  step "sign out"
end

Given(/^I am signed in as an owner$/) do
  @user = FactoryGirl.create(:owner)
  sign_in_with(@user.email, @user.password)
end

When(/^I sign back in as an owner$/) do
  step "I am signed in as an owner"
end

When(/^I sign in with "(.*?)"\/"(.*?)"$/) do |email, password|
  sign_in_with(email, password)
end

def sign_in_with(email, password)
  visit '/users/sign_out'
  visit '/users/sign_in'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_on "Sign in"
end

Then(/^you should be able to sign in with "(.*?)" \/ "(.*?)"$/) do |email, password|
  sign_in_with(email, password)
  page.has_content?("Invalid").must_equal false
end

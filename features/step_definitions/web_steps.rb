When(/^I click on "(.*?)"$/) do |link_text|
  click_on link_text
end

When(/^I enter "(.*?)" as email$/) do |email|
  fill_in :user_email, with: email
end

When(/^he enters "(.*?)" as password$/) do |password|
  fill_in :user_password, with: password
end

When(/^he enters "(.*?)" as password confirmation$/) do |password|
  fill_in :user_password_confirmation, with: password
end

When(/^he clicks on "(.*?)"$/) do |link_text|
  click_on link_text
end

Then(/^he should see "(.*?)" in the email field$/) do |text|
  page.find("#user_email").value.must_equal text
end

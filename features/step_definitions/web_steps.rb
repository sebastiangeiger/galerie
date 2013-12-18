When(/^I click on "(.*?)"$/) do |link_text|
  click_on link_text
end

When(/^I enter "(.*?)" as email$/) do |email|
  fill_in :user_email, with: email
end

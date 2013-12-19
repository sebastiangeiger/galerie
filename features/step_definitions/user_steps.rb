Given(/^I have the account "(.*?)" with the password "(.*?)"$/) do |email, password|
  FactoryGirl.create(:user, email: email, password: password)
end

Then(/^I should be able to access the admin page$/) do
  visit '/admin'
  page.has_content?("Admin#index").must_equal true
end

When(/^I go to the user management page$/) do
  visit '/admin/users'
end

Then(/^I should see (\d+) users?$/) do |size|
  page.all('table#users tbody tr').size.must_equal size.to_i
end

Then(/^I should see "(.*?)" in the users table$/) do |text|
  page.all('table#users tbody td').
    select{|cell| cell.text.include? text}.
    wont_be :empty?
end

Then(/^I should see my email address in the users table$/) do
  @user.wont_be_nil
  @user.email.wont_be :blank?
  within('table#users') do
    page.has_content?(@user.email).must_equal true
  end
end

Then(/^I should see my name in the users table$/) do
  @user.wont_be_nil
  @user.name.wont_be :blank?
  within('table#users') do
    page.has_content?(@user.name).must_equal true
  end
end

Then(/^the role of "(.*?)" should be "(.*?)"$/) do |email, role|
  TableParser.new(page,"table#users").
    find_row(email: email).
    find_column(:role).
    text.must_equal(role)
end

Then(/^my role should be "(.*?)"$/) do |role|
  @user.wont_be_nil
  @user.email.wont_be :blank?
  step %{the role of "#{@user.email}" should be "#{role}"}
end

Then(/^the status of "(.*?)" should be "(.*?)"$/) do |email, status|
  TableParser.new(page,"table#users").
    find_row(email: email).
    find_column(:status).
    text.must_equal(status)
end

Then(/^my status should be "(.*?)"$/) do |status|
  @user.wont_be_nil
  @user.email.wont_be :blank?
  step %{the status of "#{@user.email}" should be "#{status}"}
end

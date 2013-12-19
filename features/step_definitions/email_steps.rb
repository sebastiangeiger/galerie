Then(/^"(.*?)" received an email$/) do |email_address|
 ActionMailer::Base.deliveries.
   select{|email| email.to.include? email_address}.
   wont_be :empty?
end

When(/^"(.*?)" clicks on the confirmation link in the email$/) do |email_address|
  body = ActionMailer::Base.deliveries.
   select{|email| email.to.include? email_address}.first.body
  links = Nokogiri::HTML(body.raw_source).css('a')
  raise "Expected to find 1 link, found #{links.size}" unless links.size == 1
  visit links.first["href"]
end

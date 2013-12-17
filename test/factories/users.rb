# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  VALID_PASSWORD = "mysecret"
  sequence(:email) { |i| "mail.address.#{i}@test.com" }
  sequence(:name) { |i| "User ##{i}" }
  factory :user, aliases: [:seller] do
    email
    password VALID_PASSWORD
    name
  end
end

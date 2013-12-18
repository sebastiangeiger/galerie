# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  VALID_PASSWORD = "mysecret"
  sequence(:email) { |i| "mail.address.#{i}@test.com" }
  sequence(:name) { |i| "User ##{i}" }
  factory :user do
    email
    password VALID_PASSWORD
    name
    role "user"
    confirmed_at Time.now
    factory :artist do
      role "artist"
    end
    factory :owner do
      role "owner"
    end
  end
end

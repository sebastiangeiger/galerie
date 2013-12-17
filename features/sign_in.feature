Feature: Signing in
  In order to use special features
  As an anonymous user with an account
  I want to be able to sign in to the page

  Scenario: Signing in
    Given I am not signed in
    And I have the account "user@example.com" with the password "mysecret"
    When I sign in with "user@example.com"/"mysecret"
    Then I should be able to access the admin page

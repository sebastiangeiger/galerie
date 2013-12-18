Feature: User management
  In order to determine who can do what
  As the owner of the site
  I want to be able to manage users

  Scenario: Seeing all users
    Given I am signed in as an owner
    When I go to the user management page
    Then I should see 1 user
    And I should see my email address in the users table
    And I should see my name in the users table
    And my role should be "Owner"
    And my status should be "Confirmed"

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

  Scenario: Creating new users
    Given I am signed in as an owner
    When I go to the user management page
    And I click on "New User"
    And I enter "someone@example.com" as email
    And I click on "Create User"
    Then I should see "someone@example.com" in the users table
    And the role of "someone@example.com" should be "Artist"
    And the status of "someone@example.com" should be "Not confirmed"
    When I sign out
    And "someone@example.com" clicks on the confirmation link in the email
    And I sign back in as an owner
    And I go to the user management page
    Then the status of "someone@example.com" should be "Confirmed"

Feature: Provide authentication
  In order provide user sessions and security
  As a user
  I want to be able to log in

  Scenario: User logs in
  Given I am not signed in
    And I have a valid account
  When I sign in with valid credentials
  Then I should be authenticated
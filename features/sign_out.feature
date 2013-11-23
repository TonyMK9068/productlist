Feature: Provide authentication
  In order provide user sessions and security
  As a user
  I want to be able to log out

  Scenario: User logs in
  Given I am signed in
  When I click the 'Sign Out' button
  Then my session should be terminated
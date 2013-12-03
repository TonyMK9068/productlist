Feature: Sharing content
  In order to allow users to share their activity
  As a user
  I want to be able to provide a readable link to my list by via email and popular social networking sites.

  Scenario: User views created lists
  Given I am logged in
    And I have a list titled 'Christmas'
  When I click 'My Profile'
  Then I should see a link to my list 'Christmas'

  Scenario: User decides to share by email
  Given I am logged in
    And I have a list titled 'thunder'
    And I am at 'My Profile'
  When I opt to share my 'thunder' list with user 'member@example.com'
  Then an email containing a link to my list should be sent to 'member@example.com'
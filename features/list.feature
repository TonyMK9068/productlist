Feature: Creating and managing a list
  In order to create a new list
  As a user
  I user I must enter a a title, event description, and date

  Scenario: User navigates to New List page
  Given I am logged in
  When I click "Create List"
  Then I should see "Create New List"

  Scenario: User creates New List
  Given I am logged in
    And I am at the "new list" page
  When I create a new list titled "Hello World"
  Then I should see "Hello World" after saving

  Scenario: User visits personal index
  Given I am logged in
  When I click "Profile"
  Then I should see my index

  Scenario: User views personal index
  Given I am logged in
    And I have a page titled "chocolate"
  When I click "Profile"
  Then I should see "chocolate"

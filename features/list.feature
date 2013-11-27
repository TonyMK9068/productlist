Feature: Creating and managing a list
  In order to create a new list
  As a user
  I user I must enter a a title, event description, and date

  Scenario: User navigates to New List page
  Given I am logged in
  When I click "Create List"
  Then I should see "Create A New List"

  Scenario: User creates New List
  Given I am logged in
    And I am at the "new list" page
  When I create a new list titled "Hello World"
  Then I should see "Hello World" after saving

  Scenario: User visits personal index
  Given I am logged in
  When I click "My Home"
  Then I should see my index

  Scenario: User views personal index
  Given I am logged in
    And I have a list titled "chocolate"
  When I click "My Home"
  Then I should see "chocolate"

  Scenario: User views a list
  Given I am logged in
    And I have a list titled "Christmas list"
    And I am at my personal index
  When I click the "Christmas List" link
  Then I should see my page's detailed view

  Scenario: User is viewing detailed view for list
  Given I am logged in
    And I have a list titled "oranges"
  When I visit the list detailed view
  Then I should see a search box to lookup products
    And I should see all of my lists
    And I should see a link to edit my list

  Scenario: User looks up products
  Given I am logged in
    And I have a list titled "Thanksgiving"
    And I am at the list detailed view
  When I search for "Harry Potter"
  Then I should see a list of products related to "Harry Potter"

  Scenario: User decides to add product to list
  Given I am logged in
    And I have a list titled "Milk"
    And I have searched for "Gift Cards"
  When I click "List It" on the first product
  Then the product should be added to my list
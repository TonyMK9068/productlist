Feature: User index
  In order to display to a user all of their submissions
  As a user
  I should be able to view all of my submissions orgranized by category

  Scenario: User views personal index
    Given that I am signed in
    When I visit my index
    Then I should be able to view all my products by category

  Scenario: User views personal index
    Given that I am signed in
    When I visit my index
    Then I should be able to view all produts by date added, in descending order

   Scenario: User views personal index
    Given that I am signed in
    When I visit my index
    Then I should be able to view all of my lists

   Scenario: User views personal index
    Given that I am signed in
      And viewing my index
    When I view my lists
    Then the lists should be ordered by date of event, in descending order
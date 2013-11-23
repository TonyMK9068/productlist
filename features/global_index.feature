Feature: Index of global submissions
  In order to allow users to view submissions by others
  As a user
  I should be able to view submissions by all other members

  Scenario: User views global index
    Given that I am signed in
    When I visit the global index
    Then I should be able to view popular lists or products

  Scenario: User views global index
    Given that I am signed in
    When I visit the global index
    Then I should be able to sort lists by popularity
      And I should be able to sort products by event type

  Scenario: User views global index
    Given that I am signed in
    When I visit the global index
    Then I should be able to sort products by popularity
      And I should be able to sort products by category
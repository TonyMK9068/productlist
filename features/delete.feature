Feature: In order to add user controll over bookmarks
  As a user
  I should be able to delete previous bookmarks

  Scenario: User deletes product
    Given I am logged in
      And viewing a list
    When I delete the product
    Then the product should be removed from my list

  Scenario: User deletes list
    Given I am logged in
      And viewing a list
    When I delete the list
    Then the list should be removed from the database
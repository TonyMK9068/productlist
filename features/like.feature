Feature: In order to add to promote viewing submissions by others
As a user
I should be able to 'like' submissions which will then by saved to my account

  Scenario: User likes a product
    Given I am logged in
      And viewing a product added by a different user
    When I click the 'like' button
    Then the product should be added to my personal index

  Scenario: User unlikes a product
    Given I am logged in
      And viewing a product added by a different user
      And I have liked the product
    When I click the 'unlike' button
    Then the product should be removed from my personal index

  Scenario: User likes a list
    Given I am logged in
      And viewing a list created by a different user
    When I click the 'like' button
    Then the list should be added to my personal index

  Scenario: User unlikes a list
    Given I am logged in
      And viewing a list created by a different user
    When I click the 'like' button
    Then the list should be added to my personal index
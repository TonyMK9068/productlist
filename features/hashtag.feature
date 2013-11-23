Feature: Offer social categorization
  In order to provide users a way to add descriptions to their submisions
  As a user
  I should be able to append a hashtag

  Scenario: User adds hashtag to list
  Given I have a valid account
    And I have created a list
  When I add a hashtag to the title
  Then my list should added to that category in the global index

  Scenario: User adds hashtag to product
  Given I have a valid account
    And I have added a product
  When I add a hashtag to the title
  Then the product should added to that category in the global index
guide Feature: In order to allow users to share their activity
As a user
I should be able to share my lists and products on popular social media sites

  Scenario: User shares list with FB
    Given I am logged in
      And I have added a list
      And I have added my facebook credentials to my giftshare account
    When I click 'Share with Facebook'
    Then my list should be added to my facebook account

  Scenario: User shares list with Twitter
    Given I am logged in
      And I have added a product
      And I have added my twitter credentials to my giftshare account
    When I click 'Share with Twitter'
    Then my product should be added to my twitter account 

  Scenario: User shares product with FB
    Given I am logged in
      And I have added a product
      And I have added my facebook credentials to my giftshare account
    When I click 'Share with Facebook'
    Then my list should be added to my facebook account

  Scenario: User shares product with Twitter
    Given I am logged in
      And I have added a product
      And I have added my twitter credentials to my giftshare account
    When I click 'Share with Twitter'
    Then my product should be added to my twitter account 
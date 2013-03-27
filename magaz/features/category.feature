Feature: Category
  Create, update, delete product category
  Create, update, delete subcategory
  Choice category for product 
  Show product in category

  @firefox
  Scenario: Create category
    Given I am user
    And I am on the products page
    When I click add category
    And I fill the category name and click save
    Then new category should appear

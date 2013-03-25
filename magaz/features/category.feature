Feature: Category
  Create, update, delete product category
  Create, update, delete subcategory
  Choice category for product 
  Show product in category

  Scenario: Create category
    Given I am user
    And on products page
    When click add category
    And type category name and click save
    Then new category appear and selected
    And no products in new categoty

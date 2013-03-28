Feature: Category
  Create, update, delete product category
  Create, update, delete subcategory
  Choice category for product 
  Show product in category

  @browser
  Scenario: Create category
    Given I am user on the products page
    When I click on add category
    And I fill the category name 
    And I click on save
    Then new category should appear

  @browser
  Scenario: Edit category
    Given I am user on the products page
    And category exist
    When I click on edit category button
    And I fill the category name 
    And I click on save
    Then category should name should be changed

  @browser
  Scenario: Delete category
    Given I am user on the products page
    And category exist
    When I click on delete category button
    And I confirm delete
    Then I should not see category
    And I reload page
    And I should not see category

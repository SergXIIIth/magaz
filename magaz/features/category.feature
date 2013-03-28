Feature: Category
  Create, update, delete product category
  Create, update, delete subcategory
  Choice category for product 
  Show product in category

  @browser
  Scenario: Create
    Given I am user on the products page
    When I click on add category
    And I fill the category name 
    And I click on save
    Then new category should appear

  @browser
  Scenario: Edit
    Given I am user on the products page
    And category exist
    When I click on edit category button
    And I fill the category name 
    And I click on save
    Then category should name should be changed

  @browser
  Scenario: Delete
    Given I am user on the products page
    And category exist
    When I click on delete category button
    And I confirm delete
    Then I should not see category
    And I reload page
    And I should not see category

  @browser
  Scenario: Choice a categories for the product
    Given I am user 
    And product exist
    And category exist
    And I visit the product page
    When I click on select category button
    And I select category
    And I close dialog
    Then I should see chosen category
    When I click on save
    And I visit the product page
    Then I should see chosen category

  @browser
  Scenario: Remove the product from the category
    Given I am user
    And product with category exist
    And I visit the product page
    When I click delete category
    Then I should not see chosen category
    When I click on save
    And I visit the product page
    Then I should not see chosen category

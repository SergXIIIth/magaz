class Spinach::Features::Category < Spinach::FeatureSteps
  step 'I am user on the products page' do
    login
  end

  step 'product exist' do
    @product = create(:product)
  end

  step 'category exist' do
    @category = create(:category)
  end

  step 'category assigned to product' do
    @product.category_ids << @category.id
    @product.save!
  end

  step 'I visit the products page' do
    visit admin_products_path
  end

  step 'I click on add category' do
    find('.new-category-btn').click
  end

  step 'I fill the category name' do
    @category_hash = build(:category)
    fill_in 'name', with: @category_hash.name
  end

  step 'I fill the subcategory name' do
    @subcategory_hash = build(:category)
    fill_in 'name', with: @subcategory_hash.name
  end

  step 'I click on save' do
    find('.save-btn').click
  end

  step 'new category should appear' do
    page.should have_content @category_hash.name
  end

  step 'new subcategory should appear' do
    find('.subcategories').should have_content @subcategory_hash.name
  end

  step 'I should see subcategory after reload page' do
    visit admin_products_path
    page.should have_content @subcategory_hash.name
  end

  step 'category should name should be changed' do
    page.should have_selector '.category', count: 1
    page.should have_content @category_hash.name
  end

  step 'I click on edit category button' do
    find('.open-actions-btn').click
    find('.edit-category-btn').click
  end

  step 'I click on delete category button' do
    find('.open-actions-btn').click
    find('.detele-category-btn').click
    sleep 0.5
  end

  step 'I click on add subcategory' do
    find('.open-actions-btn').click
    find('.add-subcategory-btn').click
  end

  step 'I should not see category' do
    page.should_not have_content @category.name
  end

  step 'I reload page' do
    visit admin_products_path
  end

  step 'I confirm delete' do
    find('.delete-confirm-btn').click
  end

  step 'I am user' do
    login
  end

  step 'I click on select category button' do
    find('.choice-category-btn').click
    sleep 0.5
  end

  step 'I select category' do
    find('.category-choice-dialog .category').click
  end

  step 'I close dialog' do
    find('.close').click
  end

  step 'I should see chosen category' do
    page.should have_content @category.name
  end

  step 'I visit the product page' do
    visit edit_admin_product_path @product
  end

  step 'I click on remove category from project' do
    find('.chosen-categories .delete-btn').click
  end

  step 'I should not see chosen category' do
    page.should_not have_content @category.name
  end
end

class Spinach::Features::Category < Spinach::FeatureSteps
  step 'I am user on the products page' do
    login
    visit admin_products_path
  end

  step 'I click on add category' do
    find('.new-category-btn').click
  end

  step 'I fill the category name' do
    @category = build(:category)
    fill_in 'name', with: @category.name
  end

  step 'I click on save' do
    find('.save-btn').click
  end

  step 'new category should appear' do
    page.should have_content @category.name
  end

  step 'category exist' do
    @exist_category = create(:category)
  end

  step 'category should name should be changed' do
    page.should have_selector '.category', count: 1
    page.should have_content @category.name
  end

  step 'I click on edit category button' do
    find('.edit-category-btn').click
  end

  step 'I click on delete category button' do
    find('.detele-category-btn').click
  end

  step 'I should not see category' do
    page.should_not have_content @exist_category.name
  end

  step 'I reload page' do
    visit admin_products_path
  end

  step 'I confirm delete' do
    sleep 0.5
    find('.delete-confirm-btn').click
  end
end

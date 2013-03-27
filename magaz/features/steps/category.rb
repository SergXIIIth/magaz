class Spinach::Features::Category < Spinach::FeatureSteps
  step 'I am user' do
    login
  end

  step 'I am on the products page' do
    visit admin_products_path
  end

  step 'I click add category' do
    find('.new-category-btn').click
  end

  step 'I fill the category name and click save' do
    @category = build(:category)
    fill_in 'name', with: @category.name
    find('.save-btn').click
  end

  step 'new category should appear' do
    page.should have_content @category.name
  end
end

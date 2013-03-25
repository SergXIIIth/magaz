class Spinach::Features::Category < Spinach::FeatureSteps
  step 'I am user' do
    login
  end

  step 'on products page' do
    visit admin_products_path
  end

  step 'click add category' do
    pending 'step not implemented'
  end

  step 'type category name and click save' do
    pending 'step not implemented'
  end

  step 'new category appear and selected' do
    pending 'step not implemented'
  end

  step 'no products in new categoty' do
    pending 'step not implemented'
  end
end

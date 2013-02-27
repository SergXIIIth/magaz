# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::ProductsController do
  it 'index' do
    login
    visit admin_products_path
    page.should have_content 'Товары'
  end

  it 'create' do
    login
    visit admin_products_path
    click_on 'Добавить товар'

    page.should have_content 'Товар'

    click_on 'Сохранить'
    
    page.should have_content 'Без имени'
  end

  it 'edit' do
    product = FactoryGirl.create(:product_full).decorate

    login
    visit product.edit_path

    find("[name='name']").value.should    == product.name
    find("[name='price']").value.should   == product.price.to_s
    find("[name='amount']").value.should  == product.amount.to_s
    find("[name='desc']").value.should    == product.desc

    click_on 'Сохранить'

    page.should have_content product.name
  end
end

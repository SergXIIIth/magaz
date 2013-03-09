# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::ImagesController do
  def image_path
    path = File.join(::Rails.root, "spec/data/image.jpg") 
  end

  def upload_new_image(product)
    product.images << Magaz::CloudinaryUploader.upload(Magaz::Image.new, image_path)
    product.save!
  end

  it 'upload', js: true do
    login
    visit new_admin_product_path
    find('.show-upload').click

    page.execute_script("$('.image-field').show()") # input hidden for AJAX upload
    attach_file('image', image_path)
    sleep(10)

    page.should have_selector('img.origin')

    click_on 'Сохранить'
    find('.product .thumbnail a').click

    page.should have_selector('img.origin')
  end

  it 'croping', js: true do
    product = FactoryGirl.create(:product).decorate
    upload_new_image(product)

    login
    visit product.edit_path
    find('img.origin').click
    sleep(1.5)

    find('.modal h3').text.should == 'Картинка'

    find('.modal .save-btn').click
    sleep(1.5)
    click_on 'Сохранить'

    page.should have_selector('.product a')
  end

  it 'delete image' do
    product = FactoryGirl.create(:product).decorate
    upload_new_image(product)

    login
    visit product.edit_path
    find('.thumbnail .remove').click
    click_on 'Сохранить'
    find('.product .thumbnail a').click

    page.should_not have_selector('img.origin')
  end

  it 'delete image - cancel' do
    product = FactoryGirl.create(:product).decorate
    upload_new_image(product)

    login
    visit product.edit_path
    find('.thumbnail .remove').click
    click_on 'Назад'
    find('.product .thumbnail a').click

    page.should have_selector('img.origin')
  end
end

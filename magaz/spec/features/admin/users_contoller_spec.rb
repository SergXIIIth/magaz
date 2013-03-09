# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::UsersController do
  
  it 'fill email', js: true do
    OmniAuth.config.mock_auth[:vkontakte][:info][:email] = ''
    login
    page.should have_content 'Ваши данные'
    find('.error-email').visible?.should == false

    click_on 'Продолжить'
    page.should have_content 'Ваши данные'
    sleep(1.5)
    find('.error-email').visible?.should == true

    fill_in('email', with: 'sergey@makridenkov.com')
    click_on 'Продолжить'
    page.should_not have_content 'Ваши данные'
  end

end

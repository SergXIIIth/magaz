# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::SessionsController do
  
  it 'login' do
    visit login_path
    find('.vkontakte').click

    page.should have_content 'Sergey'
    page.should have_content 'Makridenkov'
  end

  it 'login without email' do
    OmniAuth.config.mock_auth[:vkontakte][:info][:email] = ''
    visit login_path
    find('.vkontakte').click

    page.should have_content 'Ваши данные'
  end
end

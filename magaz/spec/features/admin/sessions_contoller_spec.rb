# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::SessionsController do
  it 'login' do
    login
    page.should have_content 'Sergey'
    page.should have_content 'Makridenkov'
  end

  it 'logout' do
    login
    visit logout_path
    page.should have_content 'Вход'
  end
end

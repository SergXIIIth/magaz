# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::SessionsController do
  it 'new' do
    visit '/auth/developer'
    fill_in 'name', with: 'Sergey Makridenkov'
    fill_in 'email', with: 'sergey@makridenkov.com'
    click_on 'Sign In'

    page.should have_content 'Sergey Makridenkov'
  end
end

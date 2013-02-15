# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::Admin::SessinsController do
  it 'new' do
    visit '/auth/developer/callback'
  end
end

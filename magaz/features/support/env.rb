ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'rspec-rails'
require 'spinach/capybara'
require 'capybara/poltergeist'

include FactoryGirl::Syntax::Methods


Spinach.hooks.before_scenario do
  Mongoid.purge!
end

def login(user = nil)
  user = create(:user)
 
  OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
    provider:   user.provider,
    uid:        user.uid,
    extra:      {raw: {}},
    info:       {
                  first_name: user.name, 
                  last_name:  user.surname, 
                  email:      user.email,
                }
  )

  OmniAuth.config.test_mode = true

  @current_user = user
  visit login_path
  find('.vkontakte').click 
end
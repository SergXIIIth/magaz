ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'rspec'
require 'spinach/capybara'
require 'capybara/poltergeist'

include FactoryGirl::Syntax::Methods


Spinach.hooks.before_scenario do
  Mongoid.purge!
end

Spinach.hooks.on_tag("js") do
  ::Capybara.current_driver = :poltergeist
  ::Capybara.default_wait_time = 5
end

Spinach.hooks.on_tag("browser") do
  ::Capybara.current_driver = :selenium
  ::Capybara.default_wait_time = 5
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

def debug
  sleep 25
end
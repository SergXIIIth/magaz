Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :vkontakte, ENV['VK_KEY'], ENV['VK_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :odnoklassniki, ENV['ODNOKLAS_KEY'], ENV['ODNOKLAS_SECRET'], :public_key => ENV['ODNOKLAS_PUBLIC']
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
end
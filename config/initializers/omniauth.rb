Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['API_KEY'], ENV['API_SECRET']
end
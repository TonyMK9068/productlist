# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
# end
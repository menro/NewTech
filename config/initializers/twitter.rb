Twitter.configure do |config|
  config.oauth_token_secret = configatron.twitter.oauth_token_secret
  config.oauth_token = configatron.twitter.oauth_token
  config.consumer_secret = configatron.twitter.consumer_secret
  config.consumer_key = configatron.twitter.consumer_key
end
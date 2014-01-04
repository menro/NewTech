def load_env(filename)
  if File.exist?(filename)
    File.readlines(filename).grep(/\A\s*\w+\=/) do |line|
      ENV.send :[]=, *line.split('=', 2).map(&:strip)
    end
  end
end

load_env('.env')
load_env(".env_#{Rails.env}")


# application base
configatron.host = ENV['HOST']
configatron.app_name = ENV['APP_NAME']
configatron.secret_token = ENV['SECRET_TOKEN']
configatron.session_store = ENV['SESSION_STORE']

# Email
configatron.email.delivery_method = ( ENV['EMAIL_DELIVERY_METHOD'] || "smtp" ).to_sym
configatron.email.enable_starttls_auto = ENV['EMAIL_START_SSL']
configatron.email.address = ENV['EMAIL_FROM_ADDRESS']
configatron.email.noreply =  ENV['EMAIL_NO_REPLY']
configatron.email.port = ENV['EMAIL_PORT']
configatron.email.domain = ENV['EMAIL_DOMAIN']
configatron.email.user_name = ENV['SENDGRID_USERNAME'] #ENV['EMAIL_USER_NAME']
configatron.email.password = ENV['SENDGRID_PASSWORD'] #ENV['EMAIL_PASSWORD']
configatron.email.authentication = ENV['EMAIL_AUTHENTICATION']

#S3
configatron.avatar.default_url =  ENV['STORAGE_DEFAULT_URL']
configatron.s3.bucket = ENV['AWS_BUCKET']
configatron.s3.credentials.access_key_id = ENV['AWS_ACCESS_KEY_ID']
configatron.s3.credentials.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']

configatron.twitter.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
configatron.twitter.oauth_token = ENV['OAUTH_TOKEN']
configatron.twitter.consumer_secret = ENV['CONSUMER_SECRET']
configatron.twitter.consumer_key = ENV['CONSUMER_KEY']

configatron.angellist.access_token = ENV['ANGEL_LIST_ACCESS_TOKEN']
configatron.angellist.client_id = ENV['ANGEL_LIST_CLIENT_ID']


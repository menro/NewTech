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
configatron.email.address = 'smtp.sendgrid.net' #ENV['EMAIL_FROM_ADDRESS']
configatron.email.noreply = 'noreply@bdnt.org' #ENV['EMAIL_NO_REPLY']
configatron.email.port = ENV['EMAIL_PORT']
configatron.email.domain = 'heroku.com' #ENV['EMAIL_DOMAIN']
configatron.email.user_name = 'app9227271@heroku.com' #ENV['SENDGRID_USERNAME'] #ENV['EMAIL_USER_NAME']
configatron.email.password = 'u0jzlh12' #ENV['SENDGRID_PASSWORD'] #ENV['EMAIL_PASSWORD']
configatron.email.authentication = ENV['EMAIL_AUTHENTICATION']

#S3
configatron.avatar.default_url =  ENV['STORAGE_DEFAULT_URL']
configatron.s3.bucket = ENV['AWS_BUCKET']
configatron.s3.credentials.access_key_id = ENV['AWS_ACCESS_KEY_ID']
configatron.s3.credentials.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']






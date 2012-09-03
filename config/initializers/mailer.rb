ActionMailer::Base.delivery_method = configatron.email.delivery_method
ActionMailer::Base.default_url_options = { :host => configatron.host }

ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => configatron.email.enable_starttls_auto,
    :address => configatron.email.address,
    :port => configatron.email.port,
    :domain => configatron.email.domain,
    :user_name => configatron.email.user_name,
    :password => configatron.email.password,
    :authentication => configatron.email.authentication
}
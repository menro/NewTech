def load_env(filename)
  if File.exist?(filename)
    File.readlines(filename).grep(/\A\s*\w+\=/) do |line|
      ENV.send :[]=, *line.split('=', 2).map(&:strip)
    end
  end
end

load_env('.env')
load_env(".env_#{Rails.env}")


configatron.app_name = ENV['APP_NAME']




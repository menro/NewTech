# unicorn's configuration file.
#The above assumes a standard Rails app with ActiveRecord and New Relic for monitoring.
#For information on other available configuration operations,
#see Unicorn’s documentation(http://unicorn.bogomips.org/Unicorn/Configurator.html).

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 20
preload_app true
listen ENV['PORT'].to_i || 3000, tcp_nopush: false

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  if defined?(Resque)
    Resque.redis.quit
  end

end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    uri = URI.parse(ENV["REDISTOGO_URL"])
    Resque.redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
    Rails.logger.info('Connected to Redis')
  end

  # Reset the object cache store (Dalli)
  if Rails.cache.respond_to?(:reset)
    Rails.cache.reset
    Rails.logger.info('Rails cache has been reset')
  end

end

<<<<<<< HEAD
# unicorn's configuration file.
#The above assumes a standard Rails app with ActiveRecord and New Relic for monitoring.
#For information on other available configuration operations,
#see Unicorn’s documentation(http://unicorn.bogomips.org/Unicorn/Configurator.html).



worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true
=======
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 30
preload_app true
listen ENV['PORT'].to_i || 3000, tcp_nopush: false
>>>>>>> 6c591761b7b4476ee6128c4db25cc1b9d16bbdd1

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

<<<<<<< HEAD
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
=======
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  if defined?(Resque)
    Resque.redis.quit
  end

>>>>>>> 6c591761b7b4476ee6128c4db25cc1b9d16bbdd1
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

<<<<<<< HEAD
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
=======
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
>>>>>>> 6c591761b7b4476ee6128c4db25cc1b9d16bbdd1

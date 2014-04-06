working_directory "/home/deploy/apps/tmcyf_production/current"
pid "/home/deploy/apps/tmcyf_production/shared/tmp/pids/unicorn.pid"
stdout_path "/home/deploy/apps/tmcyf_production/shared/log/unicorn.stdout.log"
stderr_path "/home/deploy/apps/tmcyf_production/shared/log/unicorn.stderr.log"

listen "/tmp/unicorn.tmcyf_production.sock"
worker_processes 5
timeout 30

preload_app true

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "/home/deploy/apps/tmcyf_production/current/Gemfile"
end

before_fork do |server, worker|
  # Disconnect since the database connection will not carry over
  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end

  # Quit the old unicorn process
  old_pid = "/tmp/unicorn.tmcyf_production.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  if defined?(Resque)
    Resque.redis.quit
  end

  sleep 1
end

after_fork do |server, worker|
  # Start up the database connection again in the worker
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = 'localhost:6379'
  end
end
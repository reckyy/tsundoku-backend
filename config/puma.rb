# frozen_string_literal: true

# Puma configuration file.
# See https://puma.io/puma/Puma/DSL.html for more details.

# Set the number of threads each worker can use.
threads_count = ENV.fetch('RAILS_MAX_THREADS', 3)
threads threads_count, threads_count

# Specifies the port that Puma will listen on to receive requests.
# （必要に応じて3001を維持）
port ENV.fetch('PORT', 3001)

# Specifies the environment that Puma will run in.
environment ENV.fetch('RAILS_ENV', 'development')

# Allow puma to be restarted by `bin/rails restart`.
plugin :tmp_restart

# Specify the PID file if specified.
pidfile ENV['PIDFILE'] if ENV['PIDFILE']

# Use multiple workers in production (optional)
if ENV['RAILS_ENV'] == 'production'
  require 'concurrent-ruby'
  worker_count = Integer(ENV.fetch('WEB_CONCURRENCY') { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

# Set worker timeout for development
worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

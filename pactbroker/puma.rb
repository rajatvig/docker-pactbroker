# Change to match your CPU core count
workers 2

# Min and Max threads per worker
threads 1, 6

app_dir = '/var/run/pactbroker'
log_dir = '/var/log/pactbroker'

shared_dir = "#{app_dir}/shared"

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{log_dir}/puma.stdout.log", "#{log_dir}/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"

activate_control_app

set :stage, :production
set :branch, 'master'

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :site, "tmcyf.org"
server '162.243.103.14', user: 'deploy', roles: %w{web app db}, primary: true

# NGINX

set :nginx_ssl_cert, 'p-tmcyf'
set :nginx_ssl_cert_key, 'p-tmcyf'
set :nginx_ssl_cert_local_path, "config/certs/p-tmcyf.crt"
set :nginx_ssl_cert_key_local_path, "config/certs/p-tmcyf.key"

# UNICORN

set :unicorn_service, -> { "unicorn_#{fetch(:application)}_#{fetch(:stage)}" }
set :unicorn_pid, -> { unicorn_default_pid_file }

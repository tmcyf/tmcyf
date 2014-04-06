lock '3.1.0'

set :application, 'tmcyf'
set :user, 'deploy'
set :repo_url, 'git@github.com:tmcyf/tmcyf.git'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# RBENV

set :rbenv_type, :system
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# NGINX

set :nginx_server_name, 'tmcyf.org'
set :nginx_config_name, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :nginx_pid, '/run/nginx.pid'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:full_app_name)}"

set :scm, :git
set :branch, 'master'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :linked_files, %w{config/database.yml .env config/certs/p-tmcyf.crt config/certs/p-tmcyf.key}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5

namespace :nginx do

  desc 'Setup nginx configuration'
  task :setup do
    on roles(:web) do
      execute :sudo, :cp, "#{shared_path}/config/tmcyf_production.conf", '/etc/nginx/sites-available/tmcyf_production.conf'
      execute :sudo, :ln, '-fs', "/etc/nginx/sites-available/tmcyf_production.conf", "/etc/nginx/sites-enabled/tmcyf_production.conf"
      if test("[ -f /etc/nginx/sites-available/default ]")
        execute :sudo, :rm, "/etc/nginx/sites-available/default"
      end
      if test("[ -f /etc/nginx/sites-enabled/default ]")
        execute :sudo, :rm, "/etc/nginx/sites-enabled/default"
      end
    end
  end

  desc 'Reload nginx configuration'
  task :reload do
    on roles :web do
      execute :sudo, "/etc/init.d/nginx reload"
    end
  end

  before :setup, "deploy:upload_configs"

end

namespace :unicorn do

  desc 'Setup Unicorn initializer'
  task :setup do
    on roles(:app) do
      execute :sudo, :cp, "#{shared_path}/config/tmcyf_production", '/etc/init.d/tmcyf_production'
      execute :sudo, 'chmod +x /etc/init.d/tmcyf_production'
      execute :sudo, 'update-rc.d -f tmcyf_production defaults'
    end
  end

  desc 'Restarts Unicorn'
  task :start do
    on roles(:app) do
      execute :sudo, "service tmcyf_production start"
    end
  end

  desc 'Restarts Unicorn'
  task :stop do
    on roles(:app) do
      execute :sudo, "service tmcyf_production stop"
    end
  end

  desc 'Restarts Unicorn'
  task :restart do
    on roles(:app) do
      execute :sudo, "service tmcyf_production restart"
    end
  end

end

namespace :deploy do

  before :deploy, "deploy:upload_configs"
  before :deploy, "deploy:check"

  desc  'Upload configuration files'
  task :upload_configs do
    on roles(:app) do
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('.env', "#{shared_path}/.env")
      upload!("config/deploy/files/nginx.conf", "#{shared_path}/config/tmcyf_production.conf")
      upload!("config/deploy/files/unicorn.rb", "#{shared_path}/config/unicorn.rb")
      upload!("config/deploy/files/tmcyf_production", "#{shared_path}/config/tmcyf_production")
      upload!("config/certs/p-tmcyf.crt", "#{shared_path}/config/certs/p-tmcyf.crt")
      upload!("config/certs/p-tmcyf.key", "#{shared_path}/config/certs/p-tmcyf.key")
    end
  end

  after :started, 'unicorn:setup'
  after :started, 'nginx:setup'
  after :publishing, 'nginx:reload'
  after :publishing, 'unicorn:restart'

end

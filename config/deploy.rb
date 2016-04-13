require './lib/capistrano/dsl/paths'
require './lib/capistrano/dsl/helpers'

include Capistrano::DSL::Helpers
include Capistrano::DSL::Paths

lock '3.1.0'

set :application, 'tmcyf'
set :user, 'deploy'
set :repo_url, 'git@github.com:tmcyf/tmcyf.git'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# RBENV

set :rbenv_type, :system
set :rbenv_ruby, '2.0.0-p451'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# SLACK

set :slack_team, "tmcyf"
set :slack_token, "Qv4bm0x9Lm8gAB5sZLMNxpe0"
set :slack_channel,      ->{ '#dev' }
set :slack_username,     ->{ 'capistrano' }
set :slack_msg_starting, ->{ "#{ENV['USER'] || ENV['USERNAME']} has started deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage} on #{fetch :ip}." }
set :slack_msg_finished, ->{ "#{ENV['USER'] || ENV['USERNAME']} has finished deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :stage} on #{fetch :ip}." }
set :slack_msg_failed,   ->{ "*ERROR!* #{ENV['USER'] || ENV['USERNAME']} failed to deploy branch #{fetch :branch} of #{fetch :application} to #{fetch :stage} on #{fetch :ip}." }


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:full_app_name)}"

set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5

namespace :nginx do

  desc 'Setup nginx configuration'
  task :setup do
    on roles(:web) do
      sudo_upload! template('nginx_conf.erb'), nginx_sites_available_file
      sudo :ln, '-fs', nginx_sites_available_file, nginx_sites_enabled_file
    end
  end

  desc 'Remove default Vhosts'
  task :remove_defaults do
    on roles(:web) do
      if file_exists?(nginx_default_sites_enabled_file)
        execute :sudo, :rm, nginx_default_sites_enabled_file
        puts "removed default sites-enabled file"
      else
        puts "no default sites-enabled file to remove"
      end
      if file_exists?(nginx_default_sites_available_file)
        execute :sudo, :rm, nginx_default_sites_available_file
        puts "removed default sites-available file"
      else
        puts "no default sites-available file to remove"
      end
    end
  end

  desc 'Setup nginx ssl certs'
  task :setup_ssl do
    on roles :web do
      next if file_exists?(nginx_ssl_cert_file) && file_exists?(nginx_ssl_cert_key_file)
      sudo_upload! fetch(:nginx_ssl_cert_local_path), nginx_ssl_cert_file
      sudo_upload! fetch(:nginx_ssl_cert_key_local_path), nginx_ssl_cert_key_file
      sudo :chown, 'root:root', nginx_ssl_cert_file
      sudo :chown, 'root:root', nginx_ssl_cert_key_file
    end
  end

  desc 'Reload nginx configuration'
  task :reload do
    on roles :web do
      sudo nginx_service_path, 'reload'
    end
  end

end

namespace :unicorn do

  desc 'Setup Unicorn initializer'
  task :setup_initializer do
    on roles :app do
      sudo_upload! template('unicorn_init.erb'), unicorn_initd_file
      execute :sudo, 'chmod +x', unicorn_initd_file
      execute :sudo, 'update-rc.d', '-f', fetch(:unicorn_service), 'defaults'
    end
  end

  desc 'Setup Unicorn app configuration'
  task :setup_app do
    on roles :app do
      upload! template('unicorn.rb.erb'), unicorn_config
    end
  end

end

namespace :logs do

  desc 'Tail logs'
  task :tail do
  trap("INT") { puts '...Interupted'; exit 0; }
    on roles(:app), in: :sequence, wait: 5 do
      execute "tail -f #{shared_path}/log/#{fetch(:stage)}.log"
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
    end
  end

  desc 'Restart unicorn application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "/etc/init.d/unicorn_#{fetch(:full_app_name)} restart"
    end
  end

  after :started, 'nginx:setup'
  after :started, 'nginx:setup_ssl'
  after :started, 'nginx:remove_defaults'

  after :updated, 'unicorn:setup_app'
  after :updated, 'unicorn:setup_initializer'

  after :publishing, 'nginx:reload'
  after :publishing, 'deploy:restart'

end

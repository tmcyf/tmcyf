set :stage, :production
set :branch, 'master'

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

server '192.241.162.86', user: 'deploy', roles: %w{web app}, primary: true
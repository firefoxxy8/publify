# config valid only for Capistrano 3.2
lock '~> 3.2.1'

set :application, 'typo'
set :repo_url, 'matijs@mist.matijs.net:git/typo.git'
set :branch, 'toxic-elephant'
set :linked_files, %w{config/database.yml}
set :linked_dirs, fetch(:linked_dirs, []) + %w{log tmp/pids public/files}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

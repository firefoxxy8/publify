# config valid only for Capistrano 3.4
lock '~> 3.6.0'

set :application, 'typo'
set :repo_url, 'matijs@mist.matijs.net:git/typo.git'
set :branch, 'toxic-elephant'
set :linked_files, %w{config/database.yml .env}
set :linked_dirs, fetch(:linked_dirs, []) + %w{log tmp/pids public/files}
set :passenger_restart_with_touch, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end
end

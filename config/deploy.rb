# Magic incantation to give sudo a tty/pty/whatever.
# See: http://weblog.jamisbuck.org/2007/10/14/capistrano-2-1
default_run_options[:pty] = true

set :application, "typo"
set :repository,  "."

set :deploy_to, "/var/www/#{application}"

set :scm, :git

set :deploy_via, :copy
set :copy_strategy, :export

role :app, "mist.matijs.net"
role :web, "mist.matijs.net"
role :db,  "mist.matijs.net", :primary => true


namespace :deploy do
  # FIXME: Make more descriptive name
  task :post_setup do
    sudo "chown matijs:matijs #{deploy_to}"
    sudo "chown matijs:matijs #{releases_path}"
    # logdir
    sudo "chgrp -R www-data #{shared_path}/log"

    database_configuration = <<-EOF
development:
  adapter: sqlite3
  database: db/#{application}_dev.sqlite3

test:
  adapter: sqlite3
  database: db/#{application}_test.sqlite3

production:
  adapter: postgresql
  database: #{application}
  host: 
  username: #{application}
  password: 
EOF

    sudo "mkdir -p #{deploy_to}/#{shared_dir}/config" 
    sudo "chgrp -R www-data #{deploy_to}/#{shared_dir}/config"
    sudo "chmod 770 #{deploy_to}/#{shared_dir}/config"
    put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml" 
    sudo "chmod 750 #{deploy_to}/#{shared_dir}/config"
  end

  task :fix_public_dir do
    # Make public dir accessible to www-data
    sudo "chgrp -R www-data #{current_release}/public"
    # Link in the resource folder
    run "ln -nfs #{shared_path}/files #{current_release}/public/files" 
  end

  task :link_db_config do
    # Link in the production database.yml 
    run "ln -nfs #{shared_path}/config/database.yml #{current_release}/config/database.yml" 
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :bundler do
  task :bundle_new_release, :roles => :app do
    run "cd #{release_path} && bundle install --without test"
  end
end

after "deploy:setup", "deploy:post_setup"
after "deploy:update_code", "deploy:link_db_config", "deploy:fix_public_dir", "bundler:bundle_new_release

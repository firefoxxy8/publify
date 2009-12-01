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
  desc "After setup: adjust ownership of necessary directories"
  task :after_setup do
    sudo "chown matijs:matijs #{deploy_to}"
    sudo "chown matijs:matijs #{releases_path}"
    # logdir
    sudo "chgrp -R www-data #{shared_path}/log"
  end

  desc "Create database.yml in shared/config" 
  task :after_setup do
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

  desc "Touchups after symlink"
  task :after_symlink do
    # Make public dir accessible to www-data
    sudo "chgrp -R www-data #{current_path}/public"
    # Link in the production database.yml 
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{current_path}/config/database.yml" 
    # Link in the resource folder
    run "ln -nfs #{shared_path}/files #{current_path}/public/files" 
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

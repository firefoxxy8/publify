require 'mongrel_cluster/recipes'

set :application, "typo"
set :repository,  "."

set :mongrel_conf, "/etc/mongrel-cluster/sites-enabled/#{application}.yml"
set :mongrel_port, 3100
set :mongrel_servers, 2
set :mongrel_prefix, "/blog"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/www.matijs.net/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :deploy_via, :copy
set :copy_strategy, :export

role :app, "mist.matijs.net"
role :web, "mist.matijs.net"
role :db,  "mist.matijs.net", :primary => true

namespace :deploy do
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

  desc "Touchups after update_code"
  task :after_update_code do
    # Make public dir accessible to www-data
    sudo "chgrp -R www-data #{current_path}/public"
    # Link in the production database.yml 
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{current_path}/config/database.yml" 
  end

end

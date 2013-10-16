# Make bundler play nice:
require "bundler/capistrano"

# Magic incantation to give sudo a tty/pty/whatever.
# See: http://weblog.jamisbuck.org/2007/10/14/capistrano-2-1
default_run_options[:pty] = true

set :application, "typo"

set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :repository, '/home/matijs/git/typo.git'
set :local_repository, 'matijs@mist.matijs.net:git/typo.git'
set :branch, "toxic-elephant"

set :use_sudo, false

role :app, "mist.matijs.net"
role :web, "mist.matijs.net"
role :db,  "mist.matijs.net", :primary => true

set :bundle_cmd, "/var/lib/gems/1.9.1/bin/bundle"
set :bundle_flags, "--quiet"

namespace :deploy do
  # FIXME: Make more descriptive name
  task :create_shared_db_config do
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

  desc "Give apache access to public directory"
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


after "deploy:setup", "deploy:create_shared_db_config"
after "deploy:update_code", "deploy:link_db_config", "deploy:fix_public_dir"

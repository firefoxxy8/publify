require 'mongrel_cluster/recipes'

set :application, "typo"
set :repository,  "."

set :mongrel_conf, "/etc/mongrel-cluster/sites-enabled/#{application}.yml"

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

after :update_code do
  sudo "chgrp -R www-data #{current_path}/public"
end

require 'bundler/capistrano'
# require 'capistrano/local_precompile'

default_run_options[:pty] = true
set :default_environment, {
    "PATH" => "/opt/rbenv/shims:/opt/rbenv/bin:$PATH"
}
set :ssh_options, { forward_agent: true }

set :application, 'ihc_production'
set :repository, 'git@github.com:ihcby/ihc_by.git'
set :user, "deploy"
set :use_sudo, false

set :rsync_cmd, "rsync --delete -av "
# set :precompile_cmd, "RAILS_ENV=production #{fetch(:bundle_cmd, 'bundle')} exec rake assets:precompile"

task :prod do
  server 'ihc.by', :web, :app, :db, :primary => true
end

task :vagrant do
  server '10.10.10.10', :web, :app, :db, :primary => true
end

after 'deploy:finalize_update', 'symlink:all'

namespace :figaro do
  desc 'SCP transfer figaro configuration to the shared folder'
  task :setup do
    transfer :up, 'config/application.yml', "#{shared_path}/config/application.yml", :via => :scp
  end

end

namespace :symlink do
  task :db do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc 'Symlink application.yml to the release path'
  task :figaro do
    run "ln -sf #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end

  task :all do
    symlink.db
    symlink.figaro
  end
end

namespace :deploy do

  task :start do
    run "#{current_path}/bin/unicorn -Dc #{shared_path}/config/unicorn.rb -E #{rails_env} #{current_path}/config.ru"
  end
  task :restart do
    run "kill -USR2 $(cat #{shared_path}/pids/unicorn.pid)"
  end



end


after 'deploy:restart', 'deploy:cleanup'
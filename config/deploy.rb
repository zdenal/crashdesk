require 'bundler/capistrano'
require 'rvm/capistrano'

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "deploy@176.58.123.103"
role :app, "deploy@176.58.123.103"
role :db,  "deploy@176.58.123.103", :primary => true

# Bundler
set :bundle_without, [:development, :test]

# Source code
set :application, "crashdesk"
set :scm, :git
set :repository, "git@github.com:zdenal/crashdesk.git"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true, :port => 22 }
set :application, 'crashdesk'
set :deploy_to, "/mnt/app/#{application}"

set :rvm_ruby_string, '1.9.3-p194@crashdesk'
set :rvm_bin_path, '/usr/local/rvm/bin'
set :rvm_type, :system

default_run_options[:pty] = true

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do

  namespace :assets do
    desc "deploy the precompiled assets"
    task :precompile, :roles => :app, :except => { :no_release => true } do
      run_locally "bundle exec rake RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:clean"
      run_locally "bundle exec rake RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:precompile"
    end

    desc "upload assets to release"
    task :upload, :roles => :app, :except => { :no_release => true } do
      run "mkdir -p #{shared_path}/assets/#{current_revision}"
      run_locally "cd public/assets && tar cjf /tmp/assets.tar.bz2 ."
      top.upload "/tmp/assets.tar.bz2", "#{shared_path}/assets/#{current_revision}", :via => :scp
      run "cd #{shared_path}/assets/#{current_revision} && tar xjf assets.tar.bz2"
      run "rm -f assets.tar.bz2; true"
    end

    desc "symlink assets to app"
    task :symlink, :roles => :app, :except => { :no_release => true } do
      on_rollback do
        if previous_release
          run <<-CMD
            rm -f #{current_path}/public/assets;
            ln -s #{shared_path}/assets/#{previous_revision} #{current_path}/public/assets;
            true
          CMD
        else
          logger.important "no previous release to rollback to, rollback of symlink skipped"
        end
      end

      run <<-CMD
        rm -rf #{latest_release}/public/assets &&
        mkdir -p #{latest_release}/public &&
        mkdir -p #{shared_path}/assets &&
        ln -s #{shared_path}/assets/#{current_revision} #{latest_release}/public/assets
      CMD
    end
  end

end

before 'deploy:setup', 'rvm:install_ruby'
before "deploy:update_code", "deploy:assets:precompile" unless ENV['SKIP_ASSETS_PRE']
after  "deploy:update_code", "deploy:assets:upload" unless ENV['SKIP_ASSETS']
before "deploy:restart",     "deploy:assets:symlink" unless ENV['SKIP_ASSETS']

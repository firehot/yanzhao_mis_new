#add bundler support
require 'bundler/capistrano'
set :application, "yanzhao_mis_new"
set :repository, "."
set :deploy_via, :copy
set :copy_cache, true

set :scm, :git
set :branch,:master
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
server "bg.yanzhaowuliu.com",:app,:web,:db,:primary => true

set :user,"root"
set :use_sudo,false
default_run_options[:pty]=true

#set rvm support
set :default_environment, {
  'PATH' => "/usr/local/rvm/gems/ree-1.8.7-2011.03/bin:/usr/local/rvm/bin:$PATH",
  'RUBY_VERSION' => 'ree 1.8.7',
  'GEM_HOME'     => '/usr/local/rvm/gems/ree-1.8.7-2011.01@rails2_gemset',
  'GEM_PATH'     => '/usr/local/rvm/gems/ree-1.8.7-2011.03:/usr/local/rvm/gems/ree-1.8.7-2011.01@rails2_gemset',
  'BUNDLE_PATH'     => '/usr/local/rvm/gems/ree-1.8.7-2011.03'
}
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  desc "create cache dir"
  task :create_cache_dir,:roles => :web do
     run "cd #{deploy_to}/current/tmp && mkdir cache"
     run "cd #{deploy_to}/current && chmod 777 tmp -R"
     run "cd #{deploy_to}/current && chmod 777 public -R"
  end
  after "deploy:create_symlink","deploy:create_cache_dir"
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

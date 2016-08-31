set :application, "E-juriste"
set :domain,      "31.220.20.186:65002"
set :user,		  "u927408945"
set :use_sudo,	  false
set :deploy_to,   "/home/u927408945/public_html/ejuriste_depot_beta"    
set :app_path,    "app"

set :repository,  "https://github.com/landOfCodeMonster/hello-world.git"
#set :deploy_via,  :copy
set :scm,         :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, or `none`

set :model_manager, "doctrine"
# Or: `propel`

role :web,        domain                         # Your HTTP server, Apache/etc
role :app,		  domain
role :db,         domain, :primary => true       # This may be the same as your `Web` server

set :shared_files,      ["app/config/parameters.yml"]
set :shared_children,     [app_path + "/logs", web_path + "/uploads", "vendor"]

set :use_composer, true
set :update_vendors, true

task :upload_parameters do
  origin_file = "app/config/parameters.yml"
  destination_file = shared_path + "/app/config/parameters.yml" # Notice the
  shared_path

  try_sudo "mkdir -p #{File.dirname(destination_file)}"
  top.upload(origin_file, destination_file)
end

after "deploy:setup", "upload_parameters"

set  :keep_releases,  3

# Be more verbose by uncommenting the following line
# logger.level = Logger::MAX_LEVEL
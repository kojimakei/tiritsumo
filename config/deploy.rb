lock '3.16.0'

set :application, 'tiritsumo'

set :repo_url,  'git@github.com:kojimakei/tiritsumo.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/tiritsumo"

# secret_base_keyを読み込ませるため追記
set :linked_files, %w[config/master.key]

# シンボリックリンクをはるファイル。
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/settings.yml', '.env')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/tiritsumo.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end 
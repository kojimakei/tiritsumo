server '52.199.151.77', user: 'ec2-user', roles: %w{app db web},

# CircleCIのGUIで設定した環境変数を使ってSSH接続
ssh_options: {
  port: 22,
  user: "ec2-user", # overrides user setting above
  keys: [File.expand_path('~/.ssh/id_rsa')],#'~/.ssh/id_rsa'部分をローカル環境の鍵のパスに
  forward_agent: true,
  auth_methods: %w(publickey)
}
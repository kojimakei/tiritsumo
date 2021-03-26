server '52.199.151.77', user: 'ec2-user', roles: %w{app db web},

# CircleCIのGUIで設定した環境変数を使ってSSH接続
ssh_options: {

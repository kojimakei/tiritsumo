server '52.199.151.77', user: 'ec2-user', roles: %w{app db web}


# CircleCIのGUIで設定した環境変数を使ってSSH接続
# set :ssh_options, auth_methods: ['publickey'],
#                                    keys: ['~/.ssh/id_rsa_1c199388c59ec02fd4601ec64d4e9644'] 
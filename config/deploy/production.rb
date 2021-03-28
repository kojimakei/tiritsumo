server '52.199.151.77', user: 'ec2-user', roles: %w{app db web}


set :ssh_options, auth_methods: ['publickey'],
                                   keys: ['~/.ssh/id_rsa_7c:42:54:83:59:4b:4d:76:18:a4:3f:4a:63:8a:11:62'] 

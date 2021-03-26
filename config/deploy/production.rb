server '52.199.151.77', user: 'ec2-user', roles: %w{app db web}


set :ssh_options, auth_methods: ['publickey'],
                                   keys: ['~/.ssh/tiritsumo.pem'] 

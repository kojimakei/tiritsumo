server '52.199.151.77', user: 'ec2-user', roles: %w{app db web}

set :ssh_options, {
  keys: [ENV.fetch('PRODUCTION_SSH_KEY').to_s],
  forward_agent: true,
  auth_methods: %w[publickey]
}
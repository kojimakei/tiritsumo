server '52.199.151.77', user: 'ec2-user', roles: %w{app db web}


set :ssh_options, auth_methods: ['publickey'],
                                   keys: ['~/.ssh/id_rsa_AAAAB3NzaC1yc2EAAAADAQABAAACAQDE7mb9ui6mUfQXd0TNf2Zd+BgSydnglRb/S7u7XnDWN4a3gDIRxgSb9FwK6CE94umFVyUpXBICynM8ABfsOE6fZnJfWxzLyp7Ca7eI/TRc8LuFmqgH3+EHZTJNIUEc2v9u1vasAAmVtZZ+4LW18j1oUGgmyBPHrJssPoXvwsZedah+g1tUKFoeZzGHw29JvhkiJ0I+7hmb7jHsJQbws5MZOh5aBchyuxoZiXyctSOeWll+gTPxFc9E8ucHElCniuGIypabFMT50C2t6vGr/doiT11gg+lv6dKAALXzO6cMtOiaCOrmHrBV/TKYF1vvu4n95HU8+KicP9y9mLZtNnNI9012vK4S2zUEkdgaFEfRtRYLiWFc1otR2DTvmlIPz/IAAF+zm1gwELSc40suklPUT37yu/9by1rr1jFZhjmWoen6y262CgIP0Zf27cFLxmJk/nUE7B45C08OomNyN3xAws/mB4z66pTF+wKZQsHfJBlh6PUsK9hbZl+pW8ajv1kS/9m7pjySHdxnVQ1e6hfDyx7HzXCi1E3Ig1sDpCvXTKNtrvL/PDP3BPTVTsqrIHI3z5WHpnZ08VyavszefJGIHl0wFY8P+aYpd+NnKDMwKX2EwgkIaGw3kBci/sezMN+Ujp351AFX1/GJRHWAviO5FrLl4UaTrkDTKQAHZjFS1w== ec2-user@ip-172-31-3-250.ap-northeast-1.compute.internal'] 

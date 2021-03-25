version: 2.1
orbs:
  ruby: circleci/ruby@1.1.2 

jobs:
  build:
    docker:
      - image: circleci/ruby:2.6.5
    working_directory: ~/tiritsumo
    steps:
      - checkout:
          path: ~/tiritsumo
      - ruby/install-deps

  test:
    docker:
      - image: circleci/ruby:2.6.5
      - image: circleci/mysql:5.6.51
        environment:
          MYSQL_ROOT_PASSWORD: password
          MYSQL_DATABASE:  tiritsumo_test
    environment:
      BUNDLE_JOBS: "3"
      BUNDLE_RETRY: "3"
      MYSQL_HOST: "127.0.0.1"
      RAILS_ENV: test
    working_directory: ~/tiritsumo        
    steps:
      - checkout:
          path: ~/tiritsumo
      - ruby/install-deps
      - run:
          name: Database setup
          command: bundle exec rails db:migrate
      - run:
          name: test
          command: bundle exec rake test     


  deploy:
    machine:
      enabled: true
    steps:
      - add_ssh_keys:
          fingerprints:
            - 7c:42:54:83:59:4b:4d:76:18:a4:3f:4a:63:8a:11:62
      - run: ssh -p $SSH_PORT $USER_NAME@$HOST_NAME "/home/ec2-user/tiritsumo/deploy-me.sh"



workflows:
  version: 2
  build_test_and_deploy:
    jobs:
      - build
      - test:
          requires:
            - build
      - deploy:
          requires:
            - test
          filters:
            branches:
              only: master

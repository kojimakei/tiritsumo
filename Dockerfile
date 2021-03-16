# FROM ruby:2.6.5
# RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
#     curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update && apt-get install -y --no-install-recommends\
#     nodejs \
#     yarn \
#     mariadb-client  \
#     build-essential  \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# WORKDIR /tiritsumo

# COPY Gemfile /tiritsumo/Gemfile
# COPY Gemfile.lock /tiritsumo/Gemfile.lock

# RUN gem install bundler
# RUN bundle install
# RUN yarn install --check-files
# COPY . /tiritsumo

FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
WORKDIR /tiritsumo
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /tiritsumo
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
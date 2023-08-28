FROM ruby:3.1.0

ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /app
RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets
COPY Gemfile* .
RUN bundle config set force_ruby_platform true
RUN bundle install -j4

COPY . app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME app/public
VOLUME app/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"
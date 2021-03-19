FROM ruby:2.6.3

RUN apt-get update
RUN apt-get install -y \
  build-essential \
  nodejs \
  libpq-dev \
  postgresql-client \
  yarn

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /app
# CMD

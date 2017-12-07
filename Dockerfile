FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y \
      libpq-dev \
      postgresql-contrib

RUN gem install bundler
ENV BUNDLE_PATH /ruby_gems
RUN mkdir /app
WORKDIR /app
ADD . /app

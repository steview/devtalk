FROM ruby:2.6.5

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && curl -sL https://deb.nodesource.com/setup_10.x -o /tmp/nodesource_setup.sh \
      && bash /tmp/nodesource_setup.sh \
      && apt-get update \
      && apt-get install -y \
      yarn \
      nodejs

COPY Gemfile* $APP_HOME/
ENV BUNDLE_PATH /gems

RUN gem update --system
RUN gem install bundler
RUN bundle install
RUN yarn install

COPY . $APP_HOME

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
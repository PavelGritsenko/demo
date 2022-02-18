FROM ruby:3.0.3-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential libpq-dev libsqlite3-dev curl imagemagick nodejs

WORKDIR /my-app

COPY Gemfile /my-app/Gemfile
COPY Gemfile.lock /my-app/Gemfile.lock

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN bundle install

RUN bundle update

COPY . /my-app

CMD ["rails", "server", "-b", "0.0.0.0"]
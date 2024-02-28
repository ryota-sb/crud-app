FROM ruby:3.2.2

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update -qq \
    && apt-get install -y nodejs \
    && npm install -g yarn

RUN mkdir /work

WORKDIR /work

COPY Gemfile /work/Gemfile
COPY Gemfile.lock /work/Gemfile.lock

RUN bundle config set --global force_ruby_platform true && bundle install

COPY . /work

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
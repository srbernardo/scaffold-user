FROM ruby:3.1.2

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      libjemalloc2 \
      libvips \
      postgresql-client \
      build-essential \
      git \
      libpq-dev \
      libyaml-dev \
      pkg-config && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.19 && \
    bundle install --jobs $(nproc) --retry 3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

RUN chmod +x bin/dev bin/rails

RUN bundle exec bootsnap precompile app/ lib/

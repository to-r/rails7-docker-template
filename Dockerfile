FROM ruby:3.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV BUNDLER_VERSION 2.4.6

WORKDIR /myapp

# apt-get利用リポジトリを日本サーバーに変更（インストール時間を短くする）
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# 依存のインストール
RUN set -ex && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends sudo && \
    : "Install node.js" && \
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends nodejs && \
    : "Install yarn" && \
    wget -q https://dl.yarnpkg.com/debian/pubkey.gpg && \
    sudo apt-key add pubkey.gpg && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends yarn && \
    apt-get install -y --no-install-recommends vim && \
    apt-get install -y --no-install-recommends wget &&\
    apt-get install -y --no-install-recommends zip unzip &&\
    apt-get install -y --no-install-recommends postgresql-client &&\
    apt-get install -y --no-install-recommends libvips &&\
    apt-get install -y --no-install-recommends graphviz &&\
    : "Cleaning..." && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    : "Install rails7.X latest version" && \
    gem install rails --version="~>7.0.0"

# COPY Gemfile /myapp
# COPY Gemfile.lock /myapp
# COPY package.json /myapp
# COPY yarn.lock /myapp

# RUN yarn install --check-files

# RUN gem install bundler -v $BUNDLER_VERSION
# RUN bundle _$BUNDLER_VERSION\_ install -j4

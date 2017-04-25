FROM ubuntu:16.04

MAINTAINER ZeroC0D3 Team <zeroc0d3.0912@gmail.com>

RUN apt-get update

# Install ruby dependencies
RUN apt-get install -y wget curl \
    build-essential git git-core \
    zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev

RUN apt-get update

# Install ruby-install
RUN cd /tmp &&\
  wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz &&\
  tar -xzvf ruby-install-0.6.1.tar.gz &&\
  cd ruby-install-0.6.1/ &&\
  make install

# Install MRI Ruby
RUN ruby-install ruby 2.4.0

# Add Ruby binaries to $PATH
ENV PATH /opt/rubies/ruby-2.4.0/bin:$PATH

# Add options to gemrc
RUN echo "install: --no-document\nupdate: --no-document" > ~/.gemrc

# Install bundler
RUN gem install bundler

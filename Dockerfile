#
# Dockerfile to build a GitHub Pages Jekyll site
#   - Debian Stable
#   - Ruby 3.1.2
#   - Jekyll 3.9.3
#   - GitHub Pages
#

FROM debian:stable

#
# Get the laest APT packages
#

RUN apt-get update

#
# Install Debian prerequistes for Ruby and Jekyll
#

RUN apt-get -y install git \
    curl \
    autoconf \ 
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm6 \
    libgdbm-dev \
    libdb-dev \
    apt-utils

#
# Jekyll is based on Ruby. Set the version and path.
# As of this writing, use Ruby 3.1.2
#

ENV RBENV_ROOT /usr/local/src/rbenv
ENV RUBY_VERSION 3.1.2
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH

#
# Install rbenv to manage Ruby versions
#

RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
    && git clone https://github.com/rbenv/ruby-build.git \
    ${RBENV_ROOT}/plugins/ruby-build \
    && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
    && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

#
# Install rbenv to manage Ruby versions
#

RUN rbenv install ${RUBY_VERSION} \
    && rbenv global ${RUBY_VERSION}

#
# Install the version of Jekyll that GitHub Pages  supports
# See https://pages.github.com/versions/
#

RUN gem install jekyll -v '3.9.3'

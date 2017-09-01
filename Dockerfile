FROM ruby:latest

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim man

#Nope, use sendmail on the host (port 25)... remember to start postfix on the host
#sendmail


#make sure we don't get tripped up by any inherited proxies
RUN unset HTTP_PROXY
RUN unset HTTPS_PROXY

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

#set env vars to store gems in /bundle so they can be cached

#ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
#  BUNDLE_JOBS=2 \
#  BUNDLE_PATH=/bundle

RUN bundle install

#install phantomjs
#TODO: use a separate container. See docker-compose.yml for more on what I've tried to make this work...
#taken from https://hub.docker.com/r/wernight/phantomjs/~/dockerfile/
RUN set -x  \
    # Install official PhantomJS release
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
 && mkdir /tmp/phantomjs \
 && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
    # Install dumb-init (to handle PID 1 correctly).
    # https://github.com/Yelp/dumb-init
 && curl -Lo /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb \
 && dpkg -i /tmp/dumb-init.deb \
    # Clean up
 && apt-get purge --auto-remove -y \
        curl \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/*



ADD . $APP_HOME

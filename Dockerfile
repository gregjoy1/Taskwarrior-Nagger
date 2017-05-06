FROM azukiapp/ruby:2.2.5

RUN apt-get update && apt-get install -y wget cmake make build-essential uuid-dev libgnutls-dev

COPY bin/install-taskwarrior.sh install-taskwarrior.sh

RUN bash install-taskwarrior.sh 2.5.1

RUN mkdir /taskwarrior-web

WORKDIR /taskwarrior-web

ADD Gemfile /taskwarrior-web/Gemfile
ADD taskwarrior-web.gemspec /taskwarrior-web/taskwarrior-web.gemspec
ADD lib/taskwarrior-web/version.rb lib/taskwarrior-web/version.rb
RUN bundle install

ADD . /taskwarrior-web

ADD .env .env

CMD ["/bin/bash"]

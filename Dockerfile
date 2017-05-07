FROM azukiapp/ruby:2.2.5

RUN apt-get update && apt-get install -y wget cmake make build-essential uuid-dev libgnutls-dev

COPY bin/install-taskwarrior.sh install-taskwarrior.sh

RUN bash install-taskwarrior.sh 2.5.1

RUN mkdir /taskwarrior-nagger

WORKDIR /taskwarrior-nagger

ADD Gemfile /taskwarrior-nagger/Gemfile
ADD taskwarrior-nagger.gemspec /taskwarrior-nagger/taskwarrior-nagger.gemspec
ADD lib/taskwarrior-nagger/version.rb lib/taskwarrior-nagger/version.rb
RUN bundle install

ADD . /taskwarrior-nagger

ADD .env .env

CMD ["/bin/bash"]

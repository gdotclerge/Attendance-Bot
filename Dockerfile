FROM ruby:2.3.7

WORKDIR /usr/src/Attendance-Bot

COPY ./ ./

RUN bundle install

CMD bundle exec puma -p $PORT

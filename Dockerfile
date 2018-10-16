FROM ruby:2.3.7

WORKDIR /usr/src/Attendance-Bot

COPY ./ ./

CMD ruby bin/run.rb

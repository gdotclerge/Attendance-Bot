FROM ruby:2.3.7
RUN echo ${SLACK_API_TOKEN}

WORKDIR /usr/src/Attendance-Bot

COPY ./ ./

RUN bundle install

CMD ruby bin/run.rb

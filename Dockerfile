FROM ruby:2.3.7

WORKDIR /usr/src/Attendance-Bot

COPY ./ ./

RUN bundle install --without development test

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-p", "5000"]

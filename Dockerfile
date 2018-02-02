FROM ruby:2.5-alpine

RUN apk add --update \
  build-base \
  nodejs \
  tzdata

RUN mkdir /pokemon_battle
WORKDIR /pokemon_battle

COPY Gemfile* ./
RUN bundle install --deployment

COPY . ./

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server"]

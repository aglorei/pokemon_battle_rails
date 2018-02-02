FROM ruby:2.5-alpine

RUN apk add --update \
  build-base \
  nodejs \
  tzdata

RUN addgroup -S pokemaster && \
  adduser -S -G pokemaster \
  -h /pokemon_battle \
  pokemaster

WORKDIR /pokemon_battle

COPY Gemfile* /pokemon_battle/
RUN chown -R pokemaster:pokemaster /pokemon_battle
USER pokemaster
RUN bundle install --deployment

USER root
COPY . /pokemon_battle
RUN chown -R pokemaster:pokemaster /pokemon_battle

USER pokemaster
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server"]

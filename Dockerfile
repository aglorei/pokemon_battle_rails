FROM ruby:2.5-alpine

EXPOSE 3000

RUN apk add --update \
  build-base \
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
RUN apk del --purge \
  build-base \
  && rm -rf /var/cache/apk/*
COPY . /pokemon_battle
RUN chown -R pokemaster:pokemaster /pokemon_battle

USER pokemaster

ENTRYPOINT ["bin/entrypoint"]
CMD ["bundle", "exec", "rails", "server"]

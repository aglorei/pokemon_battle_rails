FROM ruby:2.5-alpine

RUN apk add --update \
  build-base \
  nodejs \
  tzdata

RUN addgroup -S pokemaster && \
  adduser -S -G pokemaster \
  -h /pokemon_battle \
  pokemaster

USER pokemaster
WORKDIR /pokemon_battle

COPY --chown=pokemaster:pokemaster Gemfile* /pokemon_battle/
RUN bundle install --deployment

COPY --chown=pokemaster:pokemaster . /pokemon_battle
EXPOSE 3000

ENTRYPOINT ["bin/entrypoint"]
CMD ["bundle", "exec", "rails", "server"]

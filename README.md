# Pokemon Battle Rails
This repository initializes a Rails v5.1.4 server on ruby 2.5.0, configured with a single endpoint to battle Pokemon. The server fetches upstream information from [Pokeapi](https://pokeapi.co/) in order to start a battle and return fight details to the client.

## Quick Start
### Prerequisites
- [Docker](https://www.docker.com/install)
### Install
```
docker pull aglorei/pokemon_battle_rails:latest
docker run -itd \
  --name poke_rails \
  -p 3000:3000 \
  aglorei/pokemon_battle_rails
```
### Example
```
curl -X POST \
  -H 'Content-type: application/json' \
  -d '{"pokemon1": "pikachu", "pokemon2": "charmander"}' \
  localhost:3000/battle
```
### Tests
```
docker run -it \
  -e RAILS_ENV=test \
  aglorei/pokemon_battle_rails \
  bundle exec rake test
```
### Code Analyze ([Rubocop](https://github.com/bbatsov/rubocop))
```
docker run -it \
  -e RAILS_ENV=development \
  aglorei/pokemon_battle_rails \
  bundle exec rubocop
```

## Battle
### POST /battle
| Field | Type | Description |
| --- | --- | --- |
| `pokemon1` | {id or name} | ID or name of Pokemon assigned as offensive in the first round |
| `pokemon2` | {id or name} | ID or name of Pokemon assigned as defensive in the first round |
### Sample Response
```JSON
{
  "winner": "Charmander",
  "history": [
    "Pikachu has an hp of 35.0.",
    "Charmander has an hp of 39.0",
    "Pikachu attacked Charmander with 'Take-down' for a damage of 9.0.",
    "Charmander is left with an hp of 30.0.",
    "Charmander smacked Pikachu with 'Secret-power' for a damage of 7.0.",
    "Pikachu is left with an hp of 28.0.",
    "Pikachu slapped Charmander with 'Rollout' for a damage of 3.0.",
    "Charmander is left with an hp of 27.0.",
    "Charmander slapped Pikachu with 'Shadow-claw' for a damage of 7.0.",
    "Pikachu is left with an hp of 21.0.",
    "Pikachu attacked Charmander with 'Swift' for a damage of 6.0.",
    "Charmander is left with an hp of 21.0.",
    "Charmander knocked Pikachu with 'Leer' for a damage of 0.0.",
    "Pikachu is left with an hp of 21.0.",
    "Pikachu slapped Charmander with 'Bide' for a damage of 0.0.",
    "Charmander is left with an hp of 21.0.",
    "Charmander slapped Pikachu with 'Shadow-claw' for a damage of 7.0.",
    "Pikachu is left with an hp of 14.0.",
    "Pikachu attacked Charmander with 'Submission' for a damage of 8.0.",
    "Charmander is left with an hp of 13.0.",
    "Charmander attacked Pikachu with 'Headbutt' for a damage of 7.0.",
    "Pikachu is left with an hp of 7.0.",
    "Pikachu slapped Charmander with 'Thunderbolt' for a damage of 9.0.",
    "Charmander is left with an hp of 4.0.",
    "Charmander attacked Pikachu with 'Rock-slide' for a damage of 7.5.",
    "Pikachu is left with an hp of 0.0.",
    "Charmander is the triumphant winner."
  ]
}
```

## Interested in Caching?
Look [here](https://github.com/aglorei/pokemon_app), for putting Nginx and proxy cache in front of this server.

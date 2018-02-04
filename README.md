# README
This repository initializes a Rails v5.1.4 server on ruby 2.5.0, configured with a single endpoint to battle Pokemon. The server fetches upstream information from [Pokeapi](https://pokeapi.co/) in order to start a battle and return fight details to the client.

#### Quick Start
TODO

## Battle
### POST /battle
| Field | Type | Description |
| --- | --- | --- |
| `pokemon1` | {id or name} | ID or name of Pokemon assigned as offensive in the first round |
| `pokemon2` | {id or name} | ID or name of Pokemon assigned as defensive in the first round |

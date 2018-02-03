require 'test_helper'
require 'pokeapi_helper'

module Pokeapi
  class ResourcesTest < ActiveSupport::TestCase
    include PokeapiHelper

    test 'pokemon successful show request returns pokemon' do
      stub_show_pokemon_ok(1)
      pokemon = Pokeapi::Resources::Pokemon.find(1)
      assert pokemon.is_a?(Pokeapi::Resources::Pokemon)
    end

    test 'move successful show request returns move' do
      stub_show_move_ok(1)
      move = Pokeapi::Resources::Move.find(1)
      assert move.is_a?(Pokeapi::Resources::Move)
    end
  end
end

require 'test_helper'
require 'pokeapi_helper'

module Pokeapi
  class ResourcesTest < ActiveSupport::TestCase
    include PokeapiHelper

    test 'pokemon show request ok' do
      stub_show_pokemon_ok(1)
      pokemon = Pokeapi::Resources::Pokemon.find(1)
      assert pokemon.is_a?(Pokeapi::Resources::Pokemon)
    end

    test 'pokemon show request error' do
      stub_show_pokemon_error(1)
      ex = assert_raises(Pokeapi::Client::BadResponse) do
        Pokeapi::Resources::Pokemon.find(1)
      end
      assert ex.response.is_a?(Net::HTTPClientError)
    end

    test 'move show request ok' do
      stub_show_move_ok(20)
      move = Pokeapi::Resources::Move.find(20)
      assert move.is_a?(Pokeapi::Resources::Move)
    end

    test 'move show request error' do
      stub_show_move_error(20)
      ex = assert_raises(Pokeapi::Client::BadResponse) do
        Pokeapi::Resources::Move.find(20)
      end
      assert ex.response.is_a?(Net::HTTPClientError)
    end
  end
end

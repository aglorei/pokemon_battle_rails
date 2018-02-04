require 'test_helper'
require 'pokeapi_helper'

module Pokeapi
  class ResourcesTest < ActiveSupport::TestCase
    include PokeapiHelper

    test 'pokemon show request ok' do
      stub_show_pokemon_ok('bulbasaur')
      pokemon = Pokeapi::Resources::Pokemon.find('bulbasaur')
      assert pokemon.is_a?(Pokeapi::Resources::Pokemon)
    end

    test 'pokemon show request error' do
      stub_show_pokemon_error('bulbasaur')
      ex = assert_raises(Pokeapi::Client::BadResponse) do
        Pokeapi::Resources::Pokemon.find('bulbasaur')
      end
      assert ex.response.is_a?(Net::HTTPClientError)
    end

    test 'pokemon hp is positive or zero' do
      stub_show_pokemon_ok('bulbasaur')
      pokemon = Pokeapi::Resources::Pokemon.find('bulbasaur')
      assert pokemon.hp.positive?

      pokemon.hp -= pokemon.hp + 1
      assert pokemon.hp.zero?
    end

    test 'pokemon with zero hp is defeated' do
      stub_show_pokemon_ok('bulbasaur')
      pokemon = Pokeapi::Resources::Pokemon.find('bulbasaur')
      assert !pokemon.defeated?

      pokemon.hp = 0
      assert pokemon.defeated?
    end

    test 'pokemon move fills moves cache' do
      stub_show_pokemon_ok('bulbasaur')
      stub_show_move_ok('swords-dance')
      stub_show_move_ok('cut')
      pokemon = Pokeapi::Resources::Pokemon.find('bulbasaur')
      assert_not_empty keys = pokemon.moves.keys
      assert_changes -> { pokemon.moves.values.any?(&:nil?) } do
        assert(keys.each { |k| pokemon.move(k).is_a?(Pokeapi::Resources::Move) })
      end
    end

    test 'move show request ok' do
      stub_show_move_ok('swords-dance')
      move = Pokeapi::Resources::Move.find('swords-dance')
      assert move.is_a?(Pokeapi::Resources::Move)
    end

    test 'move show request error' do
      stub_show_move_error('swords-dance')
      ex = assert_raises(Pokeapi::Client::BadResponse) do
        Pokeapi::Resources::Move.find('swords-dance')
      end
      assert ex.response.is_a?(Net::HTTPClientError)
    end

    test 'move power is integer' do
      stub_show_move_ok('swords-dance')
      move = Pokeapi::Resources::Move.find('swords-dance')
      assert move.power.is_a?(Integer)
    end
  end
end

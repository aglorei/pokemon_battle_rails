require 'test_helper'
require 'pokeapi_helper'

module Pokeapi
  class BattleTest < ActiveSupport::TestCase
    include PokeapiHelper

    test 'battle sets winner and history' do
      stub_show_pokemon_ok('bulbasaur')
      stub_show_pokemon_ok('ivysaur')
      stub_show_move_ok('swords-dance')
      stub_show_move_ok('cut')

      battle = Pokeapi::Battle.new('bulbasaur', 'ivysaur')
      assert_nil battle.winner

      battle.go
      assert_not_nil battle.winner
    end
  end
end

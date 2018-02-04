require 'test_helper'
require 'pokeapi_helper'

class BattleControllerTest < ActionDispatch::IntegrationTest
  include PokeapiHelper

  test 'post to create battle ok' do
    stub_show_pokemon_ok('bulbasaur')
    stub_show_pokemon_ok('ivysaur')
    stub_show_move_ok('swords-dance')
    stub_show_move_ok('cut')

    post '/battle', params: { pokemon1: 'bulbasaur', pokemon2: 'ivysaur' }
    assert_response :ok

    response = ActiveSupport::JSON.decode(body)
    assert %w[Bulbasaur Ivysaur].include?(response['winner'])
    assert_match response['winner'], response['history'].last
  end

  test 'post to create battle not found error' do
    stub_show_pokemon_ok('bulbasaur')
    stub_show_pokemon_error('whoisthis')

    post '/battle', params: { pokemon1: 'bulbasaur', pokemon2: 'whoisthis' }
    assert_response :not_found
  end

  test 'post to create battle unparsable error' do
    stub_show_pokemon_ok('bulbasaur')
    stub_show_pokemon_error('whoisthis', body: 'unparsable')

    post '/battle', params: { pokemon1: 'bulbasaur', pokemon2: 'whoisthis' }
    assert_response :internal_server_error

    response = ActiveSupport::JSON.decode(body)
    assert_equal I18n.t('unknown_error'), response['error']
  end

  test 'post to create battle with malformed parameters' do
    stub_show_pokemon_ok('bulbasaur')

    post '/battle', params: { pokemon1: 'bulbasaur' }
    assert_response :bad_request

    response = ActiveSupport::JSON.decode(body)
    assert_match(/pokemon2/, response['error'])
  end
end

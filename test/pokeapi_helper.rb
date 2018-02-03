module PokeapiHelper
  FIXTURES_PATH = Rails.root.join('test', 'fixtures', 'pokeapi')
  REQUEST_HEADERS = {'Accept' => '*/*',
                     'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Host' => 'pokeapi.co',
                     'User-Agent' => 'Ruby'}

  def stub_show_pokemon_ok(id, options={})
    stub_show_pokemon(id, **options) do |url|
      stub_request(:get, url).
        with(headers: REQUEST_HEADERS).
        to_return(status: 200,
                  body: json_string('show_pokemon.json'),
                  headers: {'Content-type' => 'application/json'})
    end
  end

  def stub_show_move_ok(id, options={})
    stub_show_move(id, **options) do |url|
      stub_request(:get, url).
        with(headers: REQUEST_HEADERS).
        to_return(status: 200,
                  body: json_string('show_move.json'),
                  headers: {'Content-type' => 'application/json'})
    end
  end

  private

  def stub_show_pokemon(id, api_version: Pokeapi::Client::API_VERSIONS.last)
    yield("#{Pokeapi::Client::BASE_URL}/#{api_version}/pokemon/#{id}/")
  end

  def stub_show_move(id, api_version: Pokeapi::Client::API_VERSIONS.last)
    yield("#{Pokeapi::Client::BASE_URL}/#{api_version}/move/#{id}/")
  end

  def json_file(filename)
    File.join FIXTURES_PATH, filename
  end

  def json_string(filename)
    File.read json_file(filename)
  end
end

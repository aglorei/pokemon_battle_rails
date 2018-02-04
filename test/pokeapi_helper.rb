module PokeapiHelper
  FIXTURES_PATH = Rails.root.join('test', 'fixtures', 'pokeapi')
  REQUEST_HEADERS = { 'Accept' => '*/*',
                      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                      'Host' => 'pokeapi.co',
                      'User-Agent' => 'Ruby' }.freeze

  def stub_show_pokemon_ok(id)
    stub_pokeapi(url: Pokeapi::Resources::Pokemon.resource_url(id),
                 status: 200,
                 body: json_string("show_pokemon_#{id}.json"))
  end

  def stub_show_pokemon_error(id)
    stub_pokeapi(url: Pokeapi::Resources::Pokemon.resource_url(id),
                 status: 404,
                 body: json_string('show_pokemon_not_found.json'))
  end

  def stub_show_move_ok(id)
    stub_pokeapi(url: Pokeapi::Resources::Move.resource_url(id),
                 status: 200,
                 body: json_string("show_move_#{id}.json"))
  end

  def stub_show_move_error(id)
    stub_pokeapi(url: Pokeapi::Resources::Move.resource_url(id),
                 status: 404,
                 body: json_string('show_move_not_found.json'))
  end

  private

  def stub_pokeapi(url:, status:, body:)
    stub_request(:get, url)
      .with(headers: REQUEST_HEADERS)
      .to_return(status: status,
                 body: body,
                 headers: { 'Content-type' => 'application/json' })
  end

  def json_file(filename)
    File.join FIXTURES_PATH, filename
  end

  def json_string(filename)
    File.read json_file(filename)
  end
end

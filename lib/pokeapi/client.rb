require 'net/http'

module Pokeapi
  class Client
    class BadResponse < RuntimeError
      def initialize(response)
        @response = response
      end
      attr_reader :response
    end

    BASE_URL = 'https://pokeapi.co/api'
    API_VERSIONS = [
      V1 = 'v1',
      V2 = 'v2'
    ]

    def self.get(url)
      Rails.logger.info("Started Pokeapi request to #{url}")

      Net::HTTP.get_response(url).tap do |res|
        Rails.logger.info("Received #{res.code} #{res.message}")
      end
    end
  end
end
module Pokeapi
  module Resources
    class Base
      def initialize(attributes)
        @attributes = attributes
      end

      attr_reader :attributes

      def self.resource_name
        raise 'most override in subclass'
      end

      def self.resource_url(id, api_version)
        URI("#{Client::BASE_URL}/#{api_version}/#{resource_name}/#{id}/")
      end

      def self.request(id, api_version: Client::API_VERSIONS.last)
        Client.get(resource_url(id, api_version))
      end

      def self.find(id)
        response = request(id)
        raise Client::BadResponse, response unless response.code == '200'
        new ActiveSupport::JSON.decode(response.body)
      end
    end

    class Move < Base
      def self.resource_name
        'move'
      end
    end

    class Pokemon < Base
      def moves_list
        @moves_list ||= attributes['moves'].collect do |metadata|
          metadata['move']['name']
        end
      end

      def self.resource_name
        'pokemon'
      end
    end
  end
end

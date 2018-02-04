module Pokeapi
  module Resources
    class Base
      def initialize(attributes)
        @attributes = attributes
        @name = attributes['name'].capitalize
      end

      attr_reader :attributes, :name

      def self.resource_name
        raise 'most override in subclass'
      end

      def self.resource_url(id)
        URI("#{Client::BASE_URL}/#{Client::API_VERSION}/#{resource_name}/#{id}/")
      end

      def self.request(id)
        Client.get(resource_url(id))
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

      def power
        @power ||= attributes['power'].to_i
      end
    end

    class Pokemon < Base
      def self.resource_name
        'pokemon'
      end

      def initialize(*args)
        super
        @hp = attributes['stats']
              .detect { |s| s['stat']['name'] == 'hp' }['base_stat']
              .to_f
        @moves = attributes['moves']
                 .collect { |m| m['move']['name'] }
                 .each_with_object({}) { |move, acc| acc[move] = nil }
      end

      attr_reader :hp, :moves

      def move(key = moves.keys.sample)
        moves[key] ||= Move.find(key)
      end

      def hp=(value)
        @hp = value.negative? ? 0.0 : value
      end

      def defeated?
        hp.zero?
      end
    end
  end
end

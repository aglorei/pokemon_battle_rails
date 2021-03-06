module Pokeapi
  class Battle
    DAMAGE_SCALAR = 0.1
    ATTACK_VERBS = %w[attacked smacked knocked slapped].freeze

    def initialize(id1, id2)
      @contenders = [Resources::Pokemon.find(id1),
                     Resources::Pokemon.find(id2)]
      @history = ["#{contenders.first.name} has an hp of #{contenders.first.hp}.",
                  "#{contenders.last.name} has an hp of #{contenders.last.hp}"]
    end

    attr_reader :contenders, :history

    def winner
      return nil unless contenders.any?(&:defeated?)
      @winner ||= contenders.reject(&:defeated?).first
    end

    def go
      fight(*contenders.rotate!) while winner.nil?
      history << "#{winner.name} is the triumphant winner."
    end

    def fight(defender, attacker)
      move = attacker.move
      damage = move.power * DAMAGE_SCALAR
      defender.hp -= damage

      history << "#{attacker.name} #{ATTACK_VERBS.sample} " \
        "#{defender.name} with \'#{move.name}\' for a damage of #{damage}."
      history << "#{defender.name} is left with an hp of #{defender.hp}."
    end
  end
end

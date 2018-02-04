class BattleController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    battle = Pokeapi::Battle.new(params.require(:pokemon1),
                                 params.require(:pokemon2))
    battle.go
    render json: {winner: battle.winner.name, history: battle.history}
  rescue Pokeapi::Client::BadResponse => err
    begin
      render json: ActiveSupport::JSON.decode(err.response.body),
        status: err.response.code
    rescue ActiveSupport::JSON.parse_error
      render json: {error: I18n.t('unknown_error')},
        status: 500
    end
  end
end

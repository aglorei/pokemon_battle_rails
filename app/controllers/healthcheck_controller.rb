class HealthcheckController < ApplicationController
  def alive
    head :ok
  end
end

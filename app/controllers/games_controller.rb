class GamesController < ApplicationController
  def index
    @game = Game.find_by(session_id: session.id.to_s)
  end
end

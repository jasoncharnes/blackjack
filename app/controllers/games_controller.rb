class GamesController < ApplicationController
  def index
    @game = Game.find_or_create_by(session_id: session.id.to_s)
  end
end

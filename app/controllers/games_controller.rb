class GamesController < ApplicationController
  before_action :set_games, only: [:show]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to gamer_path(@game.user_id)
    else
      render 'new'
    end
  end

  def index
    @games = Game.all.page(params[:page]).per(10)
  end

  def show; end



  private

  def game_params
    params.require(:game).permit(:title, :genre, :machine).merge(user_id: current_user.id)
  end

  def set_games
    @game = Game.find(params[:id])
  end
  
end

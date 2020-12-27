class LikesController < ApplicationController
  before_action :set_game
  
  def create
    @like = Like.create(user_id: current_user.id, game_id: params[:game_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, game_id: params[:game_id])
    @like.destroy
  end
  

  private
  
  def set_game
    @game = Game.find(params[:game_id])
  end
end

class GamersController < ApplicationController
  before_action :set_gamer, only: [:show,
                                   :edit,
                                   :update,
                                   :mygames,
                                   :followings,
                                   :followers,
                                   :likes]


  def show
    @not_clear_games = Game.where(user_id: @gamer.id, status: 0)
    @cleared_games = Game.where(user_id: @gamer.id, status: 1)
    @like = Like.where(user_id: @gamer.id)
  end

  def index
    if params[:q].present?
      @q = User.ransack(params[:q])
      @gamers = @q.result(distinct: true).page(params[:page]).per(10)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = User.ransack(params[:q])
      @gamers = @q.result(distinct: true).page(params[:page]).per(10)
    end
  end

  def edit; end

  def update; end
  #def update
  #  if @gamer.update(gamer_params)
  #    redirect_to gamer_path(current_user)
  #  else
  #    render 'edit'
  #  end
  #end

  def mygames
    @games = Game.where(user_id: current_user.id).page(params[:page]).per(10)
    if params[:sta] == 'not_cleared'
      @not_cleared = Game.where(user_id: current_user.id, status: 0).page(params[:page]).per(10)
      render '/partial/_mygames_not_cleared'
    elsif params[:sta] == 'cleared'
      @cleared = Game.where(user_id: current_user.id, status: 1).page(params[:page]).per(10)
      render '/partial/_mygames_cleared'
    end
  end

  def followings
    @gamers = @gamer.followings
  end

  def followers
    @gamers = @gamer.followers
  end

  def likes
    @like = Like.find_by(user_id: @gamer.id)
    if @like != nil
      @games = Game.where(id: @like.game_id)
    end
  end
  

  private

  def gamer_params
    params.require(:user).permit(:username, :email, :sex, :ages)
  end

  def set_gamer
    @gamer = User.find(params[:id])
  end

end

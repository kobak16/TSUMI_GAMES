class GamersController < ApplicationController
  before_action :set_gamer, only: [:show,
                                   :edit,
                                   :update,
                                   :mygames,
                                   :followings,
                                   :followers]


  def show
    @not_clear_games = Game.where(user_id: @gamer.id, status: 0)
    @cleared_games = Game.where(user_id: @gamer.id, status: 1)
  end

  def index
    @gamers = User.all.page(params[:page]).per(10)
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
    # user_id == current_user.id のゲームを取得
    @games = Game.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def followings
    @gamers = @gamer.followings
  end

  def followers
    @gamers = @gamer.followers
  end
  

  private

  def gamer_params
    params.require(:user).permit(:username, :email)
  end

  def set_gamer
    @gamer = User.find(params[:id])
  end

end

class GamesController < ApplicationController
  before_action :set_games, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "積みゲーを追加しました"
      redirect_to user_path(@game.user_id)
    else
      render 'new'
    end
  end

  def index
    if params[:q].present?
      @q = Game.ransack(params[:q])
      @games = @q.result(distinct: true).page(params[:page]).per(9)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = Game.ransack(params[:q])
      @games = @q.result(distinct: true).page(params[:page]).per(9)
    end
  end

  def show; end

  def edit; end

  def update
    if params[:commit] == '登録'
      @game.clear_day = Date.today
      if @game.update(game_params)
        flash[:notice] = "積みゲーを解消しました"
        redirect_to game_path(@game)
      else
        render '/partial/_edit_clear'
      end
    elsif params[:commit] == '更新する'
      if @game.update(game_params)
        flash[:notice] = "ゲーム情報を更新しました"
        redirect_to game_path(@game)
      else
        render '/partial/_edit_cleared'
      end
    else
      if @game.update(game_params)
        flash[:notice] = "ゲーム情報を更新しました"
        redirect_to game_path(@game)
      else
        render '/partial/_edit_not_cleared'
      end
    end
  end

  def destroy
    if @game.destroy
      flash[:notice] = "ゲームを削除しました"
      redirect_to user_path(@game.user_id)
    else
      render 'show'
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :genre, :machine, :rate, :comment, :status, :image, :created_at, :updated_at, :clear_day).merge(user_id: current_user.id)
  end

  def set_games
    @game = Game.find(params[:id])
  end

  
  
end

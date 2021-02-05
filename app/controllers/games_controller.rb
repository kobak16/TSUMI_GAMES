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
    if params[:name] == 'clear'
      if @game.update(game_params)
        @clear_day =  @game.updated_at
        redirect_to game_path(@game)
      else
        render 'edit'
      end
    else
      if @game.update(game_params)
        redirect_to game_path(@game)
      else
        render 'edit'
      end
    end
  end

  def destroy
    if @game.destroy
      redirect_to user_path(@game.user_id)
    else
      render 'show'
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :genre, :machine, :rate, :comment, :status, :image, :created_at, :updated_at).merge(user_id: current_user.id)
  end

  def set_games
    @game = Game.find(params[:id])
  end

  
  
end

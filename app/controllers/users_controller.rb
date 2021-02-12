class UsersController < ApplicationController
  before_action :user_logged_in?, except: [:index]
  before_action :set_user, only: [:show,
                                  :edit,
                                  :update,
                                  :mygames,
                                  :followings,
                                  :followers,
                                  :likes]


  def show
    @not_cleared_games = Game.where(user_id: @user.id, status: 0)
    @cleared_games = Game.where(user_id: @user.id, status: 1)
    @like = Like.where(user_id: @user.id)
  end

  def index
    params[:q] = { sorts: 'created_at desc' } unless params[:q].present?
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(9)
  end

  def edit; end

  def update; end


  def mygames
    if params[:name] == 'all'
      @games = Game.where(user_id: @user.id).page(params[:page]).per(9)
    elsif params[:name] == 'not_cleared'
      @games = Game.where(user_id: @user.id, status: 0).page(params[:page]).per(9)
      render :mygames
    elsif params[:name] == 'cleared'
      @games = Game.where(user_id: @user.id, status: 1).page(params[:page]).per(9)
      render :mygames
    end
  end

  def followings
    @users = @user.followings.page(params[:page]).per(9)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(9)
  end

  def likes
    @games = Game.joins(:likes).where(likes: {user_id: @user.id}).page(params[:page]).per(9)
  end
  

  private

  def user_params
    params.require(:user).permit(:username, :email, :sex, :ages, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_logged_in?
    unless user_signed_in?
      redirect_to  '/users/sign_in'
    end
  end

end
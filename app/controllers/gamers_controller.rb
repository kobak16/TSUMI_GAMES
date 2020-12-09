class GamersController < ApplicationController
  before_action :set_gamer, only: [:show,
                                   :edit,
                                   :update]

  def show; end

  def index
    @gamers = User.all
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

  private

  def gamer_params
    params.require(:user).permit(:username, :email)
  end

  def set_gamer
    @gamer = User.find(params[:id])
  end
end
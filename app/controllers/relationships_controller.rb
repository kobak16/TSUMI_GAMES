class RelationshipsController < ApplicationController

  def create
    @gamer = User.find(params[:following_id])
    current_user.follow(@gamer)
  end

  def destroy
    @gamer = User.find(params[:id])
    current_user.unfollow(@gamer)
  end
end

class BlacklistsController < ApplicationController

  def create
    user_id = current_user.id
    @friend_id = User.find_by(id: params[:friend_id]).id
    @blacklist = Blacklist.create(user_id: user_id, friend_id: @friend_id)
    redirect_to user_path(current_user)
    # @blacklist = Blacklist.create(user_id: user_id, friend_id: params[:friend_id])
    # redirect_to user_path(current_user)
  end

  def destroy
    @blacklist = Blacklist.find(params[:id])
    # user_id = current_user.id
    # friend_id = User.find_by(uid: params[:friend_id]).id
    # blacklist = Blacklist.where(friend_id: friend_id).where(id: user_id)
    # blacklist = Blacklist.where(friend_id: params[:friend_id]).where(id: user_id)
    @blacklist.destroy

    redirect_to user_path(current_user)
  end

end

class BlacklistsController < ApplicationController

  def create
    user_id = current_user.id
    @friend_id = User.find_by(uid: params[:friend_id]).id
    @blacklist = Blacklist.create(user_id: user_id, friend_id: @friend_id)
    redirect_to user_path(current_user)
  end

  def delete
    user_id = current_user.id
    friend_id = User.find_by(uid: params[:friend_id]).id
    blacklist = Blacklist.where(friend_id: friend_id).where(id: user_id)
    blacklist.destroy

    redirect_to user_path(current_user)
  end

end

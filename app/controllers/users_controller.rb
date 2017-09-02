class UsersController < ApplicationController
   def show
    @user = current_user
    @user_friends = FacebookApiService.new(current_user.token).friends
    @blacklist = Blacklist.new
    user_id = current_user.id
    @blacklist_friends = Blacklist.where(user_id: user_id)
    @listings = Listing.where(user_id: user_id)
    @meeting = Meeting.where(listing_id: @listings.ids)
  end
end

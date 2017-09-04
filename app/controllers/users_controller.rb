class UsersController < ApplicationController
   def show
    # friends list
    @user = current_user
    @user_friends = FacebookApiService.new(current_user.token).friends
    @blacklist = Blacklist.new

    # listings overview
    user_id = current_user.id
    @blacklist_friends = Blacklist.where(user_id: user_id)
    @listings = Listing.where(user_id: user_id)
    @meeting = Meeting.where(listing_id: @listings.ids)

    #overview of huddles I participated in
    i_participated = Participant.where(user_id: @user.id)
    meeting = Meeting.where(id: i_participated.ids)
    @listings += Listing.where(meeting_id: meeting.ids)
  end
end

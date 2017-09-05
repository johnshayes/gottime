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
    meeting_ids = Participant.where(user_id: @user.id).pluck(:meeting_id)
    meetings = Meeting.where(id: meeting_ids, status: "active")
    @listings_participation = Listing.where(id: meetings.map(&:listing_id))
    @listings_participation.order(created_at: "ASC")
  end
end

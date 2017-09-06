class UsersController < ApplicationController
   def show
    # friends list
    @user = current_user
    if Rails.env.development?
      @user_friends = User.pluck(:first_name, :uid).map { |user| {"id" => user[1], "name" => user[0]}}
    else
      @user_friends = FacebookApiService.new(current_user.token).friends
    end
    @blacklist = Blacklist.new

    # listings overview
    user_id = current_user.id
    @blacklist_friends = Blacklist.where(user_id: user_id)
    @listings = Listing.where(user_id: user_id)
    @meeting = Meeting.where(listing_id: @listings.ids)

    #overview of huddles I participated in
    meeting_ids = Participant.where(user_id: @user.id).pluck(:meeting_id)
    meetings = Meeting.where(id: meeting_ids, status: "active")
    @listings_participation = Listing.where(id: meetings.map(&:listing_id)).order("created_at ASC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :location)
  end
end

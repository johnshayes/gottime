class MeetingsController < ApplicationController

  def create
    # Invoked by POST to /listings/:listing_id/meetings (path: listing_meetings)
    @meeting = Meeting.new(meeting_params) # Create new meeting instance w/ meeting params (below - see q?)
    @listing = Listing.find(params[:listing_id]) # Find listing using listing_id from url
    @meeting.listing = @listing # Makes the connection i.e. sets listing_id onto this new meeting instance
    if @meeting.save
      redirect_to listing_meeting_path(@listing, @meeting) # i.e. Goes to meetings show page
    else
      redirect_to listing_path(@listing) # i.e. redirect to the listing detail page if it fails to save
    end
  end

  # def create_particpant
  #   @particpant = Particpant.new() # To create new, empty particpant instance
  #   @particpant.user = current_user # To set user_id onto particpant instance
  #   @particpant.meeting = @meeting # To set meeting_id onto particpant instance
  # end

  def show
    # Url: /listings/:listing_id/meetings/:id(.:format) (path: listing_meeting GET)
    @meeting = Meeting.find(params[:id])
  end

private
  def meeting_params
    params.require(:meeting).permit(:status) # What does :meeting refer to?
  end
end


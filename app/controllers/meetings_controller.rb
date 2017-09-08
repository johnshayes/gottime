class MeetingsController < ApplicationController

  def show
    # Url: /listings/:listing_id/meetings/:id(.:format) (path: listing_meeting GET)
    @meeting = Meeting.find(params[:id])
    @participants = @meeting.participants
    @listing = @meeting.listing

    @chat_room = ChatRoom.includes(messages: :user).find_by(meeting_id: params[:id])
    # Rails.logger.info current_user.attributes

    @host_picture = @listing.user.try(:facebook_picture_url).to_s.gsub("square", "large")
    @participant_picture = @meeting.participants.first.user.try(:facebook_picture_url).to_s.gsub("square", "large")
  end

  # Private index page for current_user
  def index
    @meetings = Participant.where(user_id: current_user.id).collect { |p| p.meeting }

  end


  def create
    # Invoked by POST to /listings/:listing_id/meetings (path: listing_meetings)
    @meeting = Meeting.new(meeting_params) # Create new meeting instance w/ meeting params (below - see q?)
    @listing = Listing.find(params[:listing_id]) # Find listing using listing_id from url
    @meeting.listing = @listing # Makes the connection i.e. sets listing_id onto this new meeting instance
    # To create new particpant instance
    @meeting.participants.build(user: current_user)
    @meeting.participants.build(user_id: @listing.user_id )
    @meeting.chat_room = ChatRoom.new(name: "#{@listing.id}_chatroom")


    if @meeting.save
      @listing.status = "in use"
      @listing.save
      redirect_to listing_meeting_path(@listing, @meeting) # i.e. Goes to meetings show page
      match_notification(@listing, @meeting) if ENV['TWILIO_SEND'] == "true"
    else
      redirect_to listing_path(@listing) # i.e. redirect to the listing detail page if it fails to save
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    @meeting.status = "inactive"
    @meeting.save
    redirect_to user_path(current_user)
  end

private
  def meeting_params
    params.require(:meeting).permit(:status) # What does :meeting refer to?
  end


 def match_notification(listing, meeting)

    @activity = listing.activity
    @host = User.find(listing.user_id)
    @guest = current_user
    @url = "http://gottime.coffee/listings/#{listing.id}/meetings/#{meeting.id}"


    @offered_datetime_text = listing.offered_datetime_text


    @twilio_number = ENV['TWILIO_NUMBER']
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
    text = "Hi #{@guest.first_name}, you and #{@host.first_name} are meeting #{@offered_datetime_text} for #{@activity}! See details and chat at #{@url}"
    message = @client.api.account.messages.create(
      :from => @twilio_number,
      :to => ENV['TWILIO_DEMO_ACTIVE'] == "true" ? ENV['TWILIO_DEMO_RECIPIENT'] : @host.phone_number,
      :body => text,
    )
  end

end



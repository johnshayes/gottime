class ListingsController < ApplicationController
  def index
    me = current_user
    # extracting Blacklist contraints
    blacklist_me = Blacklist.where(friend_id: me.id)
    blacklist_me_ids = blacklist_me.map do |blacklist|
      blacklist["user_id"]
    end

    blacklist_others = Blacklist.where(user_id: me.id)
    blacklist_others_ids = blacklist_others.map do |blacklist|
      blacklist["friend_id"]
    end
    # extracting Facebook friends
    user_friends = FacebookApiService.new(current_user.token).friends
    uids = user_friends.map do |friend|
      friend["id"]
    end

    users = User.where.not(id: blacklist_others_ids).where.not(id: blacklist_me_ids).where(uid: uids).pluck(:id)
    listings_fb = Listing.where.not(user_id: current_user.id).where(user_id: users)
    listings_local = Listing.all.where.not(user_id: current_user.id)
    @listings = listings_fb + listings_local
  end

  def show
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.js {
        render :show
      }
      format.html {
        # redirect_to listing_path(@listing)
      }
    end
  end

  def new
    @listing = Listing.new
    # OPTIONS TO BE EXTRACTED FROM USER PROFILE LATER -- PERSONAL PREFERENCES
    @offered_datetime_text_options = [ "NOW", "+1h", "+2h", "TONIGHT", "EVENING", "NOON", "MORNING", "+3h", "+4h", "+5h", "+6h", "+7h", "+8h", "+9h", "+10h", "+11h", "+12h"]
    @activity_options = [  "🤷", "🍽", "🎉", "💘", "🛒", "🎵", "🍰", "🎤", "🚀", "🚴", "🤡", "💬", "🆙", "🎧", "🥘",
]
  end

  def create
    # @listing = Listing.create(listing_params)

    @listing = Listing.new

    @listing.offered_datetime_text = params[:listing][:offered_datetime_text]
    @listing.offered_datetime = what_is_datetime_text?(params[:listing][:offered_datetime_text])

    @listing.activity = params[:listing][:activity]

    @listing.user = User.find(current_user.id)

    @listing.save

    redirect_to listings_path
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end


  # def expiration
  #   every 5.minute do
  #     current_time = Time.now
  #     listings = Listing.where(status: "in use")
  #     meetings = Meeting.where(listing_id: listings.ids)
  #     if meetings.ids?
  #       meetings.each do |meeting|
  #         time_difference = current_time - meeting.created_at
  #         if (time_difference/3600) > 5
  #           meeting.status = "expiered"
  #           listings.status = "inactive"
  #         end
  #       end
  #     else
  #       listings.each do |listing|
  #         time_difference = current_time - listing.created_at
  #         if (time_difference/3600) > 5 || current_time < listing.offered_datetime
  #           listing.status = "inactive"
  #         end
  #       end
  #     end
  #   end
  # end

  private

  def listing_params
    params.require(:listing).permit(:activity, :offered_datetime_text)
  end

  def what_is_datetime_text?(offered_datetime_text)
    return case offered_datetime_text
      when "NOW" then DateTime.now
      when "+1h" then DateTime.now + 1.hours
      when "+2h" then DateTime.now + 2.hours
      when "+3h" then DateTime.now + 3.hours
      when "+4h" then DateTime.now + 4.hours
      when "+5h" then DateTime.now + 5.hours
      when "+6h" then DateTime.now + 6.hours
      when "+7h" then DateTime.now + 7.hours
      when "+8h" then DateTime.now + 8.hours
      when "+9h" then DateTime.now + 9.hours
      when "+10h" then DateTime.now + 10.hours
      when "+11h" then DateTime.now + 11.hours
      when "+12h" then DateTime.now + 12.hours
      when "TONIGHT" then DateTime.now.change({ hour: 22 })
      when "MORNING" then DateTime.now.change({ hour: 9})
      when "NOON" then DateTime.now.change({ hour: 12})
      when "EVENING" then DateTime.now.change({ hour: 18})
    end
  end


end

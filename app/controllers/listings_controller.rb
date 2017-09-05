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
    listings_fb = Listing.where.not(user_id: current_user.id).where(user_id: users).where(status: "open")
    # listings_local = Listing.all.where.not(user_id: current_user.id).where(status: "in use")
    # @listings = listings_fb + listings_local
    @listings = listings_fb
    @listings.order(offered_datetime: "DESC")

    # current_time = Time.now
    # time_difference = current_time - @listings.offered_datetime
    # @display_time = time_difference.translate_datetime_back_to_text
  end

  def show
    @listing = Listing.find(params[:id])
    respond_to do |format|
      format.js {
        render :show
      }
      format.html {
        render :show
      }
    end
  end

  def new
    @listing = Listing.new

    # OPTIONS TO BE EXTRACTED FROM USER PROFILE LATER -- PERSONAL PREFERENCES
    @offered_datetime_text_options = [ "NOW", "+1h", "+2h", "TONIGHT", "EVENING", "NOON", "MORNING", "+3h", "+4h", "+5h", "+6h", "+7h", "+8h", "+9h", "+10h", "+11h", "+12h"]

    @activity_options = [  "🤷", "🍽", "🎉", "💘", "🛒", "🎵", "🍰", "🎤", "🚀", "🚴", "🤡", "💬", "🆙", "🎧", "🥘",
]
    respond_to do |format|
      format.js {
        render :new
      }
      format.html {
        render :new
        # redirect_to listing_path(@listing)
      }
    end
    # OPTIONS TO BE EXTRACTED FROM USER PROFILE LATER -- PERSONAL PREFERENCES
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

  private

  def listing_params
    params.require(:listing).permit(:activity, :offered_datetime_text)
  end

  def what_is_datetime_text?(offered_datetime_text)
    return case offered_datetime_text
      when "NOW" then DateTime.now + 30.minutes
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


    def translate_datetime_back_to_text(datetime)
      return case datetime
      when datetime == hour: 22 then "TONIGHT"
      when datetime == hour: 9 then "MORINING"
      when datetime == hour: 12 then "NOON"
      when datetime == hour: 18 then "EVENING"

      now = Time.now
      time_difference = datetime - now
      return case time_difference
      when time_difference < 1.hour then "NOW"
      when time_difference > 1.hour then "+1h"
      when time_difference > 2.hours then "+2h"
      when time_difference > 3.hours then "+3h"
      when time_difference > 4.hours then "+4h"
      when time_difference > 5.hours then "+5h"
      when time_difference > 6.hours then "+6h"
      when time_difference > 7.hours then "+7h"
      when time_difference > 8.hours then "+8h"
      when time_difference > 9.hours then "+9h"
      when time_difference > 10.hours then "+10h"
      when time_difference > 11.hours then "+11h"
      when time_difference > 12.hours then "+12h"
    end



end








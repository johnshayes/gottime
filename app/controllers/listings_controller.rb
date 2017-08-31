class ListingsController < ApplicationController
  def index
    user_friends = FacebookApiService.new(current_user.token).friends
    uids = user_friends.map do |friend|
      friend["id"]
    end
    users = User.where(uid: uids).pluck(:id)
    listings_fb = Listing.where.not(user_id: current_user.id).where(user_id: users)
    listings_local = Listing.all.where.not(user_id: current_user.id)
    @listings = listings_fb + listings_local
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
    # OPTIONS TO BE EXTRACTED FROM USER PROFILE LATER -- PERSONAL PREFERENCES
    @offered_datetime_text_options = [ "NOW", "+1h", "+2h", "TONIGHT", "NOW", "+1h", "+2h", "TONIGHT"]
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

  def listing_params
    params.require(:listing).permit(:activity, :offered_datetime_text)
  end

  def what_is_datetime_text?(offered_datetime_text)
    return case offered_datetime_text
      when "NOW" then DateTime.now
      when "+1h" then DateTime.now + 1.hours
      when "+2h" then DateTime.now + 2.hours
      when "TONIGHT" then DateTime.now.change({ hour: 20 })
    end
  end


end

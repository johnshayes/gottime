class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
    # OPTIONS TO BE EXTRACTED FROM USER PROFILE LATER -- PERSONAL PREFERENCES
    @offered_datetime_text_options = [ "NOW", "+1h", "+2h", "TONIGHT", "NOW", "+1h", "+2h", "TONIGHT"]
    @activity_options = [ "Whatever", "Coffee", "Drinks", "Party", "Movies", "Coffee", "Drinks", "Party", "Movies"]

  end

  def create
    # @listing = Listing.create(listing_params)

    @listing = Listing.new

    @listing.offered_datetime_text = params[:listing][:offered_datetime_text]
    @listing.offered_datetime = what_is_datetime_text?(params[:listing][:offered_datetime_text])

    @listing.activity = params[:listing][:activity]

    @listing.user = User.find(current_user.id)

    @listing.save

    redirect_to listing_path(@listing)
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

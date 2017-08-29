class ListingsController < ApplicationController
  def index
    @listings = Listing.all.where.not(user_id: current_user.id)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.create(listing_params)
    if current_user
      @listing.user = User.find(current_user.id)
    else
      @listing.user = User.find(1)
    end
    @listing.save
    redirect_to listings_path
  end

  def listing_params
    params.require(:listing).permit(:activity, :offered_datetime_text)
  end
end

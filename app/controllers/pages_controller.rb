class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to new_listing_url unless current_user.nil?
  end

  def my_listings

  end

end

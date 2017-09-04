class ChangeListingsStatusJob < ApplicationJob
  queue_as :default

  def perform
    listings = Listing.where(status: "open")
    current_time = Time.now
    listings.each do |listing|
      expiration_time = listing.offered_datetime
      if current_time > expiration_time
        listing.status = "expired"
      end
    end
  end
end

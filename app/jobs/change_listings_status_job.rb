require 'sidekiq-scheduler'

class ChangeListingsStatusJob < ApplicationJob
  queue_as :default

  def perform
    listings = Listing.where(status: "open").where(status: "in use")
    current_time = Time.now
    listings.each do |listing|
      expiration_time = listing.offered_datetime
      if current_time > expiration_time
        listing.status = "expired"
        listing.save
      end
    end

    # outdated_listings = Listing.where(status: "open").where(NOW > offered_datetime)
    # outdated_listings.update_all(status: "expired")
  end
end

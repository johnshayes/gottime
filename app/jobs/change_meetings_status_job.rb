require 'sidekiq-scheduler'

class ChangeMeetingsStatusJob < ApplicationJob
  queue_as :default

  def perform
    meetings = Meeting.where(status: "active")
    current_time = Time.now
    meetings.each do |meeting|
      expiration_time = meeting.created_at + 5.hours
      if current_time > expiration_time
        meeting.status = "inactive"
        meeting.save
      end
    end
  end
end

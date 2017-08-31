class Meeting < ApplicationRecord
  belongs_to :listing
  has_many :messages
  has_many :participants
  has_one :chat_room


  # after_create :create_new_participant

  # def create_new_participant
  #   Participant.create()
  # end

end

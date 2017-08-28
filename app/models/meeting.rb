class Meeting < ApplicationRecord
  belongs_to :listing
  has_many :messages
  has_many :participants
end

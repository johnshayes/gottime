class Listing < ApplicationRecord
  belongs_to :user
  has_many :meetings
end

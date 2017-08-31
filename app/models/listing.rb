class Listing < ApplicationRecord
  belongs_to :user
  has_many :meetings

  def owns_listing?(current_user)
    self.user == current_user
  end

  def photo_exist?
    self.user.facebook_picture_url == nil
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

private

  def after_sign_up
    redirect_to new_listing_path
  end
end

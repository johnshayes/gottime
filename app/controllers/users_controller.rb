class UsersController < ApplicationController
   def show
    @user = current_user
    @user_friends = FacebookApiService.new(current_user.token).friends
    @blacklist = Blacklist.new
  end
end

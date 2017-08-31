require 'koala'

class FacebookApiService

  def initialize(token)
    @token = token
    @graph = Koala::Facebook::API.new(token)
  end

  def friends
    friends = @graph.get_connections("me", "friends")
    return friends
  end

end

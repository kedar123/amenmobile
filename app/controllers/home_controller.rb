class HomeController < ApplicationController
  layout 'koala'

  def index
    graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
    @likes = graph.get_connections("me", "likes")
    p "i like this"  
    p @facebook_cookies["access_token"]
    exit
  end
end


class HomeController < ApplicationController
  def index
  	order = params[:order_by].present? ? params[:order_by] : 'DESC'
  	@tweets = Tweet.includes(user: :followed).where(users: {follows: {follower_id: 1}}).order("tweets.created_at #{order}")
  end
end

class TweetsController < LoggedController
  expose(:tweet)
  expose(:tweets) { current_user.tweets }

  def index
  end

  def refresh
    Tweet.refresh(current_user)
    flash[:notice] = 'Successfully refreshed.'
    redirect_to tweets_path
  end
end

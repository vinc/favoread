class TweetsController < LoggedController
  expose(:tweet)
  expose(:tweets) { current_user.tweets }

  def index
  end

  def refresh
    respond_with Tweet.refresh(current_user), location: tweets_path
  end
end

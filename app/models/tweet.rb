class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :tid, type: String
  field :text, type: String
  field :tweeted_at, type: DateTime

  belongs_to :user

  def self.refresh(user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user.access_token
      config.access_token_secret = user.access_secret
    end

    client.favorites.each do |raw_tweet|
      unless where(tid: raw_tweet.id).exists?
        user.tweets << create do |tweet|
          tweet.tid = raw_tweet.id
          tweet.text = raw_tweet.text
          tweet.tweeted_at = raw_tweet.created_at
        end
      end
    end
  end
end

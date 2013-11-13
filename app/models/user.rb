class User < ActiveRecord::Base
   has_many :tweets

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

  def tweet_future(timestamp,status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(timestamp, tweet.id)
  end
end  


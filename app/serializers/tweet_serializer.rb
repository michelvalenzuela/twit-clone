class TweetSerializer < ActiveModel::Serializer
    
    attributes :id, :tweet, :retweet_id, :likes_count, :retweet_count
 end
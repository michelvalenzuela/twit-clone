class AddLikesCountandRetweetCountToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :likes_count, :integer, default: 0
    add_column :tweets, :retweet_count, :integer, default: 0
  end
end

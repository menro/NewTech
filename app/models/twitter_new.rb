class TwitterNew < ActiveRecord::Base
  attr_accessible :favorite_count, :favorited, :news_title, :news_url, :publisher_image_url, :publisher_name, :publisher_profile_url, :retweet_count, :retweeted, :tweet_created_at, :tweet_id, :tweet_user_description, :tweet_user_favourites_count, :tweet_user_followers_count, :tweet_user_friends_count, :tweet_user_id, :tweet_user_location, :tweet_user_name, :tweet_user_profile_image_url, :tweet_user_screen_name, :tweet_user_url, :votes
end

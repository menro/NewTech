class CreateTwitterNews < ActiveRecord::Migration
  def change
    create_table :twitter_news do |t|
      t.string :tweet_id
      t.text :news_title
      t.string :news_url
      t.integer :votes
      t.string :publisher_name
      t.string :publisher_image_url
      t.string :publisher_profile_url
      t.integer :retweet_count
      t.integer :favorite_count
      t.boolean :favorited
      t.boolean :retweeted
      t.datetime :tweet_created_at
      t.string :tweet_user_id
      t.string :tweet_user_name
      t.string :tweet_user_screen_name
      t.string :tweet_user_location
      t.string :tweet_user_description
      t.string :tweet_user_url
      t.integer :tweet_user_followers_count
      t.integer :tweet_user_friends_count
      t.integer :tweet_user_favourites_count
      t.integer :tweet_user_profile_image_url

      t.timestamps
    end
  end
end

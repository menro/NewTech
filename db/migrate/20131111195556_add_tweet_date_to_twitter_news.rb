class AddTweetDateToTwitterNews < ActiveRecord::Migration
  def change
    add_column :twitter_news, :tweet_date, :date
  end
end

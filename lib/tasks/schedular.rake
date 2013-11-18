desc 'Sync News Feed from Twitter'
namespace :trending_news do
  task sync_news_feed_from_twitter: :environment do 
    # require 'config/environment'
    puts :environment 

    client = Twitter.client

    client.home_timeline.each do |tweet_wrapper|
      # original tweet
      if tweet_wrapper.urls.count > 1 || tweet_wrapper.urls.count == 0
        puts "Skipping tweet..."
        puts tweet_wrapper.text
        puts '=' * 10
        next
      end

      # if Retweeted
      if tweet_wrapper.retweeted_status
        tweet = tweet_wrapper.retweeted_status
      else
        # if own tweet
        tweet = tweet_wrapper
      end

      # scrap news title from the link given in tweet url
      url = tweet.urls.last.url
      puts "Scraping url...#{url}"
      parsed = true
      while parsed
        begin
          doc = Nokogiri::HTML(open(url))
        rescue
          next
        end
        parsed = false
      end
      news_title = doc.at_css("title").text
      puts "Scrpeed news title...#{news_title}"
      #skip if there is no news title.
      next unless news_title.present?

      # Front end information (News Specific)
      # news_title = tweet.text
      news_url = tweet.urls.last.url
      votes = tweet.retweet_count
      publisher_name =  tweet.user.screen_name
      publisher_image_url = tweet.user.profile_image_url
      publisher_profile_url = tweet.user.url
      ############################

      # Remaining info
      tweet_id = tweet.id.to_s
      retweet_count = tweet.retweet_count
      favorite_count = tweet.favorite_count
      favorited = tweet.favorited
      retweeted = tweet.retweeted
      tweet_created_at = tweet.created_at
      tweet_date = tweet.created_at.to_date
      
      tweet_user_id = tweet.user.id.to_s
      tweet_user_name = tweet.user.name
      tweet_user_screen_name = tweet.user.screen_name
      tweet_user_location = tweet.user.location
      tweet_user_description = tweet.user.description
      tweet_user_url = tweet.user.url
      tweet_user_followers_count = tweet.user.followers_count
      tweet_user_friends_count = tweet.user.friends_count
      tweet_user_favourites_count = tweet.user.favourites_count
      tweet_user_profile_image_url = tweet.user.profile_image_url

      twitter_name = TwitterName.find_or_create_by_name(tweet_user_screen_name) do
      end

      twitter_news = TwitterNews.find_or_create_by_tweet_id(tweet.id.to_s)
      if twitter_news.new_record?
        puts 'Creating new News entry...'
        puts news_title
      else
        puts 'Updating News...'
        puts news_title
      end
      twitter_news.news_title = news_title
      twitter_news.news_url = news_url
      twitter_news.votes = votes + twitter_name.bump
      twitter_news.publisher_name = publisher_name
      twitter_news.publisher_image_url = publisher_image_url
      twitter_news.publisher_profile_url = publisher_profile_url
      twitter_news.retweet_count = retweet_count
      twitter_news.favorite_count = favorite_count
      twitter_news.favorited = favorited
      twitter_news.retweeted = retweeted
      twitter_news.tweet_created_at = tweet_created_at
      twitter_news.tweet_date = tweet_date
      twitter_news.tweet_user_id = tweet_user_id
      twitter_news.tweet_user_name = tweet_user_name
      twitter_news.tweet_user_screen_name = tweet_user_screen_name
      twitter_news.tweet_user_location = tweet_user_location
      twitter_news.tweet_user_description = tweet_user_description
      twitter_news.tweet_user_url = tweet_user_url
      twitter_news.tweet_user_followers_count = tweet_user_followers_count
      twitter_news.tweet_user_friends_count = tweet_user_friends_count
      twitter_news.tweet_user_favourites_count = tweet_user_favourites_count
      twitter_news.tweet_user_profile_image_url = tweet_user_profile_image_url
      if twitter_news.save
        puts "News successfully created. #{twitter_news.id}"
      else
        puts "There are some errors creating news."
        puts twitter_news.errors.inspect
      end
      puts '*************************************************'
    end    

    puts "Task completed successfully..."
  end
end






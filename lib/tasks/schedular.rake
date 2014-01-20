desc 'Sync News Feed from Twitter'
namespace :trending_news do
  task sync_news_feed_from_twitter: :environment do 
    # require 'config/environment'
    puts :environment 

    client = Twitter.client

    client.home_timeline({count: 101}).each do |tweet_wrapper|
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

      twitter_name = TwitterName.find_by_name(tweet_user_screen_name)

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
      twitter_news.votes = votes + (twitter_name.try(:bump) || 0)
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

    last_id = TwitterNews.last.id
    TwitterNews.where("id < ?", last_id - 500).delete_all

    puts "Task completed successfully..."
  end
end

desc 'Fetch county info from zipcodes'
task fetch_counties: :environment do 
  
end

desc 'Fetch data from angellist.'
task fetch_from_angellist: :environment do

  # AngellistApi.configure do |config|
  #   config.access_token = configatron.angellist.access_token
  # end

  # startups = AngellistApi.all_startups(:filter => :raising)
  # 1.9.3p392 :021 >   startups.per_page
  #  => 50 
  # 1.9.3p392 :022 > startups.page
  #  => 1 
  # 1.9.3p392 :023 > startups.last_page
  #  => 76 
  # 1.9.3p392 :024 > startups.first
  # startups.first.last.first.company_url
  # startups.first.last.first.name
  # startups.first.last.first.id
end

desc 'fetch data from crunchbase.'
task fetch_data_from_crunchbase: :environment do
  
  require 'open-uri'

  def file_from_url(url)
    extname = File.extname(url)
    basename = File.basename(url, extname)
    file = Tempfile.new([basename, extname])
    file.binmode
    open(URI.parse(url)) do |data|  
      file.write data.read
    end
    file.rewind
    file
  end
  companies = Crunchbase::Company.all; nil
  # pp c.entity.to_yaml
  found = false
  companies.each do |cc|
    begin
      c = cc.entity

    unless c.offices.present?
      puts 'No offices found....skipping...'
      next
    end
    
    country_code = c.offices.first["country_code"]
    
    unless country_code == 'USA'
      puts "*********************NOT IN USA**************Skipping... #{country_code}"
      next
    end
    
    # unless found 
    #   found = true if c.name == 'lifeIO'
    #   next
    # end

    state_code = c.offices.first["state_code"]
    state = State.find_by_short_name state_code
    unless state
      puts "......State does not exists in our DB......#{state_code}"
      next
    end
    city = City.find_by_name_and_state(c.offices.first['city'], state.name)

    unless city
      puts "......City does not exists in our DB......#{c.offices.first['city']} - #{state_code}"
      next
    end
    county = city.county
    unless county
      puts ".....City does not have County....#{city.name} #{city.id}"
      next
    end

    tag_code = c.category_code

    category = Category.find_by_name 'Companies'

    user  = User.where(email: 'reich.robert@gmail.com').first

    
    unless c.offices.first["zip_code"]
      puts "Zipcode do not found.....#{c.offices.first["zip_code"]}"
      next
    end
    zip = c.offices.first["zip_code"].split('-').first.to_i

    unless c.email_address.present?
      puts 'Email does not present. Skipping....'
      next
    end

    unless c.image.present?
      puts "Image does not present.... Skipping"
      # next
    end

    unless c.founded_year.present?
      puts 'Missing founded year. Skipping...'
      next
    end

    puts "============Creating Company=========:::#{c.name}"

    company = Company.where("name=? and city_id =? and county_id =?", c.name, city.id, county.id).first
    company = Company.create(name: c.name, city_id: city.id) unless company.present?
    company.county = county
    # Company.find_or_create_by_name_and_city_id_and_county_id_and_state_id(c.name, city.id, county.id, state.id)
    # company.city_id = city.id
    # company.state_id = state.id
    company.category_id = category.id
    next if company.email_address.present?
    company.tags << Tag.find_or_create_by_code(tag_code)
    unless c.image.present?
      company.image = file_from_url( "http://crunchbase.com/" + c.image.sizes.last.url )
    end
    # if company.image.present?
    #   next
    # end
    # company.image = file_from_url( "http://crunchbase.com/" + c.image.sizes.last.url )
    company.user_id = user.id
    company.email_address = c.email_address
    company.founded_year = c.founded_year
    company.homepage_url = c.homepage_url
    # company.name = c.name
    company.address = (c.offices.first["address1"] || '') + ", " + (c.offices.first["address2"] || '')
    company.zip_code = zip
    company.latitude = c.offices.first["latitude"]
    company.longitude = c.offices.first["longitude"]
    company.overview = ActionView::Base.full_sanitizer.sanitize(c.overview)
    company.phone_number = c.phone_number
    company.twitter = c.twitter_username
    company.save
    rescue
      next
    end
    # if Company.count > 600
    #   break
    # end
  end

end



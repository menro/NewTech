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

  def log_msg msg
    puts '.'
    puts '.'
    puts '**********************'
    puts msg
    puts '**********************'
    puts '.'
    puts '.'
  end

  puts 'Requesting crunchbase...'
  companies = Crunchbase::Company.all; nil
  puts "Got the data #{companies.count}"

  user  = User.where(email: 'reich.robert@gmail.com').first

  # pp c.entity.to_yaml
  found = false
  missing_cities = []
  companies.each do |cc|
    puts '===================================================================='
    begin
      c = cc.entity

    unless c.offices.present?
      log_msg 'No offices found....skipping...'
      next
    end
    
    country_code = c.offices.first["country_code"]

    unless country_code == 'USA'
      log_msg "not in USA, Skipping... #{country_code} , c.name "
      next
    end

    log_msg "#{c.name}, #{c.offices.first['city']}, #{c.offices.first['state_code']}, #{c.offices.first['zip_code']}, #{c.offices.first['country_code']}"

    unless c.offices.first["zip_code"].present?
      log_msg "Zipcode from crunchbase do not found.....#{c.offices.first['zip_code']} company: #{c.name}"
      next
    end

    state_code = c.offices.first["state_code"]
    state = State.find_by_short_name state_code
    unless state
      log_msg "State does not exists in our DB......#{state_code}"
      next
    end

    unless c.offices.first["address1"].present?
      log_msg 'Address does not present. Not Skipping...'
      # next
    end


    cty = c.offices.first['city']
    cty = cty.split(',').first
    cty = cty.try(:titleize)

    zip = c.offices.first["zip_code"].split('-').first.to_s.strip
    puts "Querying for zipcode: #{zip} . Actual zipcode was #{c.offices.first['zip_code']}"

    z = ''
    city = false
    Zipcode.where(code: zip).all.each do |zz|
      z = zz
      city = z.cities.where(name: cty).first
      break if city.present?
    end

    unless city
      missing_cities << cty
      log_msg "City does not exists in our DB......#{cty} .....#{state_code}"
      next
    end

    county = city.county
    unless county
      log_msg "City does not have County....#{city.name} #{city.id}"
      next
    end

    s = county.state
    unless s.short_name == state.short_name
      log_msg "Computed state and Crunchbase State do not match. Computed: #{s.short_name} - Crunchbase: #{state.short_name} - skipping..."
      next
    end

    tag_code = c.category_code

    category = Category.find_by_name 'Companies'

    unless c.email_address.present?
      puts 'Email does not present.  Not Skipping....'
      # next
    end

    unless c.image.present?
      puts "Image does not present.... Not Skipping"
      # next
    end

    unless c.founded_year.present?
      puts 'Missing founded year. Not Skipping...'
      # next
    end

    company = Company.where("name=? and city_id =? and county_id =?", c.name, city.id, county.id).first
    
    if company.present?
      log_msg 'Company already exists: ' + company.name
      next
    end

    log_msg "Creating Company: #{c.name}"
    company = Company.new(name: c.name, city_id: city.id) unless company.present?
    company.county = county

    company.category_id = category.id
    # next if company.email_address.present?
    company.tags << Tag.find_or_create_by_code(tag_code) if tag_code.present?
    
    unless c.image.present?
      company.image = file_from_url( "http://crunchbase.com/" + c.image.sizes.last.url )
    end

    # company.image = file_from_url( "http://crunchbase.com/" + c.image.sizes.last.url )
    company.user_id = user.id
    company.email_address = c.email_address
    company.founded_year = c.founded_year
    company.homepage_url = c.homepage_url
    company.name = c.name
    company.address = c.offices.first["address1"]
    company.address2 = c.offices.first["address2"]

    company.zip_code = zip
    company.zipcode = z #city.zipcodes.where(code: zip.to_s).first
    
    # r = Geocoder.search c.offices.first["address1"]+ ", " + (c.offices.first["address2"] || '') + ", #{county.name}" + ",#{zip}" 
    # puts "Requested geocoder for address #{c.offices.first["address1"]} ===== Got lng/lat:: #{r.first.geometry["location"]}"
    # company.latitude = r.first.geometry["location"]["lat"]
    # company.longitude = r.first.geometry["location"]["lng"]
    company.latitude = c.offices.first["latitude"]
    company.longitude = c.offices.first["longitude"]
    company.overview = ActionView::Base.full_sanitizer.sanitize(c.overview)
    company.phone_number = c.phone_number
    company.twitter = c.twitter_username
    company.save!
    rescue
      next
    end
  end
end

desc 'load zip codes into DB'
task populate_zipcodes: :environment do 
  CSV.foreach("public/List-of-Cities-States-and-Counties.csv") do |row|
    # return if count > 2
    # count += 1
    city_name = row[1].try(:titleize)
    county_name = row[3].try(:titleize)
    state_code = row[2]
    zip = row[0]
    
    zip_code = Zipcode.find_or_create_by_code(zip)
    # next unless zip_code.latitude.nil?

    unless county_name
      puts "*****************County name does not present: #{county_name}"
      next
    end

    unless city_name
      puts "*****************Cty name does not present: #{city_name}  ==== #{state_code}"
      next
    end

    state = State.find_by_short_name state_code
    unless state
      puts "************State do not exists in our DB::: #{state_code}"
      next
    end

    county = County.find_by_name_and_state_id county_name, state.id
    unless county
      puts "************County does not exists in our DB::: #{county_name} ====== #{state_code} ==== "
      # break
      next
    end

    zip_code = Zipcode.find_or_create_by_code(zip)
    
    county.zipcodes << zip_code unless county.zipcodes.collect(&:id).include?(zip_code.id)

    # next unless zip_code.latitude.nil?
    # sleep(1)
    # r = Geocoder.search "#{zip}, #{state_code}, US"
    # lat = r.first.geometry['location']['lat']
    # lng = r.first.geometry['location']['lng']
    # zip_code.latitude = lat
    # zip_code.longitude = lng
    # zip_code.save
  end
end

desc 'load zip codes into DB'
task map_companies_with_zipcodes: :environment do 
  Company.find_each do |company|
    zip_code = Zipcode.find_by_code company.zip_code
    company.zipcode_id = zip_code.try(:id)
    company.save
  end; nil
end




# ====================== New Purchased Data ==================
desc 'load data from sheet'
task load_whole_zipcodes_data: :environment do 
  count = 0
  CSV.foreach("public/USA-5-digits-codes.txt") do |row|
    count += 1
    next if count == 1

    info = row[0].split("\t")
    country = info[0]
    zipcode = info[1]
    city = info[3]
    county = info[5]
    state = info[7]
    latitude = info[15]
    longitude = info[16]

    puts "country:: #{country} -- zipcode:: #{zipcode} -- city:: #{city} "
    puts "county:: #{county} -- state:: #{state} -- latitude:: #{latitude} -- longitude:: #{longitude}"

    puts '+++++++++++++++++++++++'

    if country == 'USA'
      cntry = Country.find_or_create_by_name 'United States'
      st = cntry.states.where(name: state).first
      st = cntry.states.create!(name: state) unless st.present?

      cnty = st.counties.where(name: county).first
      cnty = st.counties.create!(name: county) unless cnty.present?

      cty = cnty.cities.where(name: city).first
      cty = cnty.cities.create!(name: city) unless cty.present?

      zpcd = cty.zipcodes.where(code: zipcode).first
      zpcd = cty.zipcodes.create!(code: zipcode, latitude: latitude, longitude: longitude) unless zpcd.present?

      cnty.zipcodes << zpcd if cnty.zipcodes.where(code: zpcd.code).blank?
    end

    # break if count == 2
  end; nil
end

# state = State.where(name: 'Colorado').first


# Startup Genome Data
# response = HTTParty.get("http://startupgenome.com/api/organizations/city/new-york", headers: {"AUTH-CODE" => '80d0c58f07e8ba8a3e33884c768ea600'})
# data = JSON.parse(response.body)
# pp data.first.last





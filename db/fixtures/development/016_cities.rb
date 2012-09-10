json = ActiveSupport::JSON.decode( File.read("#{Rails.root}/db/fixtures/files/colorado_cities_counties.json") )


json.each do |row|
  row = row.to_hash.with_indifferent_access
  next if row[:county_name].nil?

  City.create do |c|
    c.county =  County.find_by_name( row[:full_county_name].gsub!("County", "").strip)
    c.name = row[:county_name]
    c.state = row[:state_name]
    c.latitude = row[:primary_latitude]
    c.longitude = row[:primary_longitude]
  end unless City.find_by_name row[:county_name]
end
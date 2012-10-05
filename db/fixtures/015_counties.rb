json = ActiveSupport::JSON.decode( File.read("#{Rails.root}/db/fixtures/files/colorado_cities_counties.json") )


json.each do |row|
  row = row.to_hash.with_indifferent_access
  next unless row[:county_name].nil?

  name = row[:name].gsub!("County", "").strip
  County.create do |c|
    c.name = name
    c.state = row[:state_name]
    c.latitude = row[:primary_latitude]
    c.longitude = row[:primary_longitude]
  end unless County.find_by_name name
end
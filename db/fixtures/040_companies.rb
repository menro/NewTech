json = ActiveSupport::JSON.decode( File.read("#{Rails.root}/db/fixtures/files/colorado_companies.json") )

def employees_type_from_integer employees
  type_name = ""
  employees ||= 10
  if employees <= 10
    type_name = "<10"
  elsif employees > 10 && employees <= 25
    type_name = "11-25"
  elsif employees > 25 && employees <= 75
    type_name = "26-75"
  elsif employees > 75 && employees <= 250
    type_name = "76-250"
  else
    type_name = ">251"
  end
  EmployeesType.find_by_name(type_name)
end

json.each do |row|
  details = row.to_hash.with_indifferent_access
  puts "Import #{details['name']}"
  company = Company.new do |c|
    c.user = User.find_by_username("admin")
    c.name = details.delete("name")

    c.permalink = details.delete("permalink")
    c.homepage_url = details.delete("homepage_url")

    #c.hiring = false
    c.enabled = true

    c.employees_type = employees_type_from_integer(details.delete("number_of_employees"))
    c.investments_type = InvestmentsType.find(1)
    c.category = Category.find(1)

    c.founded_year  = details.delete("founded_year")
    c.twitter       = details.delete("twitter_username")
    c.email_address = details.delete("email_address")
    c.phone_number  = details.delete("phone_number")
    c.description   = details.delete("description")
    c.overview      = details.delete("overview").gsub(/<\/?[^>]+>/, '') rescue nil

    ( details.delete("tag_list").split(",") rescue [] ).each_with_index do |tag, index|
      break if index > 4
      c.tags << Tag.find_or_create_by_code(tag.strip)
    end

    offices = details.delete("offices")

    offices.each do |company_offices|
      next unless (company_offices.delete("state_code")).eql?("CO")

      city = company_offices["city"]
      c.city          = City.where("name LIKE ?","%#{city.strip.split(",").first}%" ).first rescue nil
      c.address      = company_offices.delete("address1")
      c.zip_code      = company_offices.delete("zip_code")
      c.latitude      = company_offices.delete("latitude")
      c.longitude     = company_offices.delete("longitude")
    end
    uri = details.delete("screenshot")
    #c.image = URI.parse(uri) unless uri.nil? or uri.empty?
  end
  company.save if company.valid?
end


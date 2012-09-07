class CrunchbaseService
  def self.import_companies_of_colorado

    companies_of_colorado.each do |company_of_colorado|
      puts "Import company: #{company_of_colorado['name']}"
      details = company_details company_of_colorado['permalink']
      unless details.nil?
        company = Company.create do |c|
          c.user = User.find_by_username("admin")
          c.name = details.delete("name")

          c.permalink = details.delete("permalink")
          c.homepage_url = details.delete("homepage_url")
          c.number_of_employees = details.delete("number_of_employees")
          c.founded_year = details.delete("founded_year")
          c.email_address = details.delete("email_address")
          c.phone_number = details.delete("phone_number")
          c.description = details.delete("description")
          c.overview =  details.delete("overview").gsub(/<\/?[^>]+>/, '') rescue nil

          c.category = Category.find_or_create_by_code( "undefined" )

          ( details.delete("tag_list").split(",") rescue [] ).each do |tag|
            c.tags << Tag.find_or_create_by_code(tag.strip)
          end

          offices = details.delete("offices")
          offices.each do |company_offices|
            office = Office.new do |o|
              o.description   = company_offices.delete("description")
              o.address1      = company_offices.delete("address1")
              o.address2      = company_offices.delete("address2")
              o.zip_code      = company_offices.delete("zip_code")
              o.city          = company_offices.delete("city")
              o.state_code    = company_offices.delete("state_code")
              o.country_code  = company_offices.delete("country_code")
              o.latitude      = company_offices.delete("latitude")
              o.longitude     = company_offices.delete("longitude")
            end
            c.offices << office
          end

        end
        company.destroy if company.out_of_colorado?
      end
    end
  end

  private
  def self.company_details(permalink)
    client = HTTPClient.new
    response = client.get "http://api.crunchbase.com/v/1/company/#{permalink}.js"
    status = response.header.status_code
    company = []
    unless status == 404 || status == 500
      company = JSON.parse( response.body )
    end
    company.is_a?( Array )  ? nil : company
  end

  def self.companies_of_colorado
    puts "fetch companies of colorado's"
    page=1
    results = []
    companies = []
    begin
      results = []
      client = HTTPClient.new
      response = client.get "http://api.crunchbase.com/v/1/search.js", {
          :geo  => "co",
          :range => 200,
          :page => page
      }
      status = response.header.status_code
      unless status == 404 || status == 500
        json = JSON.parse( response.body )
        results = json['results']
      end
      companies += results
      page += 1
    end while !results.empty?
    companies
  end

end
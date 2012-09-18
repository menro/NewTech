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
          c.hiring = false
          c.enabled = true

          c.employees_type = employees_type_from_integer(details.delete("number_of_employees"))
          c.investments_type = InvestmentsType.find(1)

          c.founded_year = details.delete("founded_year")
          c.email_address = details.delete("email_address")
          c.phone_number = details.delete("phone_number")
          c.description = details.delete("description")
          c.overview =  details.delete("overview").gsub(/<\/?[^>]+>/, '') rescue nil

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
              o.city          = City.where("name LIKE ?","%#{company_offices.delete("city")}%" ).first rescue nil
              o.latitude      = company_offices.delete("latitude")
              o.longitude     = company_offices.delete("longitude")
            end
            c.offices << office if( company_offices.delete("state_code").eql?("CO") && !office.city.nil? )
          end

        end
      end
    end
  end

  private

  def self.employees_type_from_integer employees
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
      type_name = ">250"
    end
    EmployeesType.find_by_name(type_name)
  end




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
class CompanyService

  def self.new_company(attributes = nil, options = {})
    company = Company.new(attributes, options)
    company.category = Category.new if company.category.nil?
    company.offices.build if company.offices.nil? || company.offices.empty?
    CompanyDecorator.new(company)
  end

  def self.create attributes
    tags_list = attributes.delete("tags_list")

    geocode = find_geocode attributes[:offices_attributes]['0']

    if geocode.nil?
      company = new_company attributes
      company.offices.first.errors.add :address1, "Pilo non"
    else
      attributes[:offices_attributes]['0'][:address1] = geocode[:formatted_address]
      attributes[:offices_attributes]['0'][:latitude] = geocode[:latitude]
      attributes[:offices_attributes]['0'][:longitude] = geocode[:longitude]

      company = Company.new attributes do |c|
        ( tags_list.split(",") rescue [] ).each do |tag|
          c.tags << Tag.find_or_create_by_code(tag.strip)
        end
      end
      company.save
    end


    CompanyDecorator.decorate(company)
  end


  def self.find_geocode(address)
    city = City.find_by_id(address[:city_id])
    results = []
    client = HTTPClient.new
    response = client.get "http://maps.googleapis.com/maps/api/geocode/json", {
        :sensor  => "false",
        :address => "#{address[:address1]}, #{city.name}"
    }
    status = response.header.status_code
    unless status == 404 || status == 500
      json = JSON.parse( response.body )
      results = json['results'][0]
    end
    return {
        :formatted_address => results['formatted_address'],
        :latitude => results['geometry']['location']['lat'],
        :longitude => results['geometry']['location']['lng']
    } rescue nil
  end

end

class CompanyService

  def self.build(attributes = nil, options = {})
    tags_list = attributes.delete("tags_list").split(",") rescue []
    company = Company.new(attributes, options) do |c|
      tags_list.each do |tag|
        c.tags << Tag.find_or_create_by_code(tag.strip)
      end
      c.offices.build if c.offices.nil? || c.offices.empty?
    end
    CompanyDecorator.new(company)
  end

  def self.create attributes
    geocode = find_geocode attributes[:offices_attributes]['0']
    if !geocode.success || geocode.accuracy.to_i < 6
      company = build attributes
      company.offices.first.errors.add :address1, "Address not founds"
    elsif !( attributes[:offices_attributes]['0'][:zip_code].eql?(geocode.zip) )
      company = build attributes
      company.offices.first.errors.add :zip_code, "Postal code not valid"
    else
      attributes[:offices_attributes]['0'][:address1] = geocode.street_address
      attributes[:offices_attributes]['0'][:latitude] = geocode.lat
      attributes[:offices_attributes]['0'][:longitude] = geocode.lng
      company = build attributes
      company.save
    end
    CompanyDecorator.decorate(company)
  end

  def self.find(id)
    CompanyDecorator.find(id)
  end

  def self.find_geocode(address)
    city = City.find_by_id(address[:city_id])
    geocode = Geokit::Geocoders::GoogleGeocoder3.geocode("#{address[:address1]}, #{address[:zip_code]}, #{city.name}")
    geocode
  end

end

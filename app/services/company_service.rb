class CompanyService

  def self.find_all_by_user(user, params = {})
    companies = user.companies.page(params[:page])
    CompanyDecorator.decorate(companies)
  end

  def self.destroy_by_user(user, params = {})
    company = user.companies.find(params[:id])
    company.destroy
  end

  def self.destroy_image_by_userr(user, params = {})
    company = user.companies.find(params[:id])
    company.image = nil
    company.save
    company
  end

  # TODO: fix duplication code
  def self.update_by_user(user, id, attributes = {})
    company = user.companies.find(id)
    tags_list = attributes.delete("tags_list").split(",") rescue []
    tags = []
    tags_list.each do |tag|
      tags << Tag.find_or_create_by_code(tag.strip)
    end
    company.tags = tags
    geocode = find_geocode attributes
    if !geocode.success || geocode.accuracy.to_i < 6
      company.errors.add :address, "Address not founds"
    elsif !( attributes[:zip_code].eql?(geocode.zip) )
      company.errors.add :zip_code, "Postal code not valid"
    else
      attributes[:address] = geocode.street_address
      attributes[:latitude] = geocode.lat
      attributes[:longitude] = geocode.lng
      company.update_attributes attributes
    end
    CompanyDecorator.new(company)
  end


  def self.create_by_user(user, attributes)
    geocode = find_geocode attributes
    if !geocode.success || geocode.accuracy.to_i < 6
      company = build(attributes)
      company.errors.add :address, "Address not founds"
    elsif !( attributes[:zip_code].eql?(geocode.zip) )
      company = build(attributes)
      company.errors.add :zip_code, "Postal code not valid"
    else
      attributes[:address] = geocode.street_address
      attributes[:latitude] = geocode.lat
      attributes[:longitude] = geocode.lng
      company = build(attributes)
      company.user = user
      company.save
    end
    CompanyDecorator.decorate(company)
  end

  def self.edit(id)
    company = Company.find(id)
    CompanyDecorator.decorate(company)
  end

  def self.update(id, attributes = {})
    user = User.find(attributes[:user_id])
    update_by_user(user, id, attributes)
  end

  def self.build(attributes = nil, options = {})
    tags_list = attributes.delete("tags_list").split(",") rescue []
    company = Company.new(attributes, options) do |c|
      tags_list.each do |tag|
        c.tags << Tag.find_or_create_by_code(tag.strip)
      end
    end
    CompanyDecorator.new(company)
  end

  def self.find(id)
    CompanyDecorator.find(id)
  end

  def self.search(params)
    companies = Company.scoped
    companies = companies.founded_from params[:from_year] unless params[:from_year].nil? || params[:from_year].empty?
    companies = companies.founded_to params[:to_year] unless params[:to_year].nil? || params[:to_year].empty?
    companies = companies.tagged_as params[:tag_code] unless params[:tag_code].nil? || params[:tag_code].empty?
    companies = companies.located_in_county params[:current_county_id] unless params[:current_county_id].nil? || params[:current_county_id].empty?
    companies = companies.are_hiring unless params[:hiring].nil? || params[:hiring].empty?
    companies = companies.employee_type(params[:employee_id]) unless params[:employee_id].nil? || params[:employee_id].empty?
    companies = companies.investment_type(params[:investment_id]) unless params[:investment_id].nil? || params[:investment_id].empty?
    companies = companies.with_category(params[:category_id]) unless params[:category_id].nil? || params[:category_id].empty?
    companies.order("`companies`.name").uniq
    CompanyDecorator.decorate(companies)
  end

  def self.find_geocode(params)
    city = City.find_by_id(params[:city_id])
    geocode = Geokit::Geocoders::GoogleGeocoder3.geocode("#{params[:address]}, #{params[:zip_code]}, #{city.name}")
    geocode
  end

end

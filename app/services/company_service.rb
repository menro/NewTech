class CompanyService

  def self.find_all_by_user(user, params = {})
    companies = user.companies.order("name ASC").page(params[:page])
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

  def self.update_by_user(user, id, attributes = {})
    attributes[:user_id] = user.id
    update(id, attributes)
  end

  def self.update(id, attributes = {})
    user = User.find(attributes[:user_id])
    company = Company.find(id)
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
      company.errors.add :zip_code, "Postal code not valid, google return address zipcode #{geocode.zip}"
    else
      attributes[:address] = geocode.street_address
      attributes[:latitude] = geocode.lat
      attributes[:longitude] = geocode.lng
      company.update_attributes attributes
    end
    CompanyDecorator.new(company)
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
    companies = CompanyService.search_companies(params)
    CompanyDecorator.decorate(companies)
  end

  def self.search_recent(params, limit=5)
    companies = CompanyService.search_companies(params).order('created_at ASC ').limit(limit)
    CompanyDecorator.decorate(companies)
  end

  def self.search_companies(params)
    companies = Company.includes(:jobs, :tags, :category, :employees_type, :investments_type, :city, :county)
    companies = companies.with_active_kickstarter unless params[:kickstarter].blank?
    companies = companies.name_like params[:company_name] unless params[:company_name].blank?
    companies = companies.founded_from params[:from_year] unless params[:from_year].blank?
    companies = companies.founded_to params[:to_year] unless params[:to_year].blank?
    companies = companies.tagged_as params[:tag_code] unless params[:tag_code].blank?
    companies = companies.located_in_county params[:current_county_id] unless params[:current_county_id].blank?
    companies = companies.are_hiring unless params[:hiring].blank?
    companies = companies.employee_type(params[:employee_id]) unless params[:employee_id].blank?
    companies = companies.investment_type(params[:investment_id]) unless params[:investment_id].blank?
    companies = companies.with_category(params[:category_id]) unless params[:category_id].blank?
    companies = companies.order('companies.name ASC')
    companies.uniq
  end

  def self.find_geocode(params)
    city = City.find_by_id(params[:city_id])
    geocode = Geokit::Geocoders::GoogleGeocoder3.geocode("#{params[:address]}, #{params[:zip_code]}, #{city.try(:name)}")
    geocode
  end

end

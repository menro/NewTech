class JobService

  def self.all
    JobDecorator.decorate(Job.all)
  end

  def self.find_all_by_user(user, params = {})
    jobs = user.jobs.order("expires_on DESC").page(params[:page])
    JobDecorator.decorate(jobs)
  end

  def self.build(attributes = nil, options = {})
    job = Job.new(attributes, options)
    JobDecorator.new(job)
  end

  def self.create_by_user(user, attributes)
    geocode = find_geocode attributes
    if !geocode.success || geocode.accuracy.to_i < 6
      job = build(attributes)
      job.errors.add :address, "Address not founds"
    elsif !( attributes[:zip_code].eql?(geocode.zip) )
      job = build(attributes)
      job.errors.add :zip_code, "Postal code not valid"
    else
      attributes[:address] = geocode.street_address
      attributes[:latitude] = geocode.lat
      attributes[:longitude] = geocode.lng
      attributes[:expires_on] = 30.days.from_now
      company = user.companies.find_by_id(attributes.delete(:company_id))
      job = build(attributes)
      job.company = company
      job.save
    end
    JobDecorator.decorate(job)
  end

  def self.edit_by_user(user, id)
    job = user.jobs.find(id)
    JobDecorator.decorate(job)
  end

  def self.update_by_user(user, id, attributes = {})
    job = user.jobs.find(id)
    geocode = find_geocode attributes
    if !geocode.success || geocode.accuracy.to_i < 6
      job.errors.add :address, "Address not founds"
    elsif !( attributes[:zip_code].eql?(geocode.zip) )
      job.errors.add :zip_code, "Postal code not valid, google return address zipcode #{geocode.zip}"
    else
      attributes[:address] = geocode.street_address
      attributes[:latitude] = geocode.lat
      attributes[:longitude] = geocode.lng
      job.update_attributes attributes
    end
    JobDecorator.new(job)
  end

  def self.find_geocode(params)
    city = City.find_by_id(params[:city_id])
    geocode = Geokit::Geocoders::GoogleGeocoder3.geocode("#{params[:address]}, #{params[:zip_code]}, #{city.name}")
    geocode
  end

  def self.kinds
    %w(Full-Time Contract/Consultant Internship Co-Founder)
  end

  def self.roles
    %w(Developer Designer Product Sales Marketing Business)
  end

  def self.search(params)
    jobs = Job.scoped.joins(:company)
    jobs = jobs.title_like params[:title] unless params[:title].blank?
    jobs = jobs.tagged_as params[:tag_code] unless params[:tag_code].blank?
    jobs = jobs.employee_type(params[:employee_id]) unless params[:employee_id].blank?
    jobs = jobs.investment_type(params[:investment_id]) unless params[:investment_id].blank?
    jobs = jobs.with_category(params[:category_id]) unless params[:category_id].blank?
    jobs = jobs.order('jobs.created_at DESC')
    jobs.uniq
    JobDecorator.decorate(jobs)
  end

end

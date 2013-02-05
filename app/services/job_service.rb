class JobService

  def self.find_all_by_user(user, params = {})
    jobs = user.jobs.order("title ASC").page(params[:page])
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
      company = Company.find_by_id(attributes.delete(:company_id))
      job = build(attributes)
      job.company = company
      job.save
    end
    JobDecorator.decorate(job)
  end

  def self.find_geocode(params)
    city = City.find_by_id(params[:city_id])
    geocode = Geokit::Geocoders::GoogleGeocoder3.geocode("#{params[:address]}, #{params[:zip_code]}, #{city.name}")
    geocode
  end

  def self.types
    %w(Full-Time Contract/Consultant Internship Co-Founder)
  end

  def self.roles
    %w(Developer Designer Product Sales Marketing Business)
  end

end

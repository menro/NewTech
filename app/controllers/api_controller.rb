class ApiController < ApplicationController

  respond_to :json

  def companies
    @companies = CompanyService::search(params)
    respond_with @companies
  end

  def tags
    @tags = TagService::search(params)
    respond_with @tags
  end

  def counties
    @counties = CountyService::search(params)
    respond_with @counties
  end

  def states
    @states = StateService::search(params)
    respond_with @states
  end

  def countries
    @countries = CountryService::search(params)
    respond_with @countries
  end

  def zipcodes
    @zipcodes = ZipcodeService::search(params)
    respond_with @zipcodes
  end

  def county
    @county = CountyService::find(params)
    respond_with @county
  end

  def zipcode
    @zipcode = ZipcodeService::find(params)
    respond_with @zipcode
  end

  def employees_types
    @employees_types = EmployeesTypeService::search(params)
    respond_with @employees_types
  end

  def investments_types
    @investments_types = InvestmentsTypeService::search(params)
    respond_with @investments_types
  end

  def categories
    puts '**************************************'
    @categories = CategoryService::search(params)
    puts @categories.inspect
    puts '=' * 100
    respond_with @categories
  end

  def jobs
    @jobs = JobService.search(params)
    respond_with @jobs
  end

  def job_kinds
    respond_with JobService.kinds
  end

  def job_roles
    respond_with JobService.roles
  end

  def skills
    @skills = SkillService::search(params)
    respond_with @skills
  end

  def recent_updates
    @recent_updates = CompanyService::get_recent_companies(params)
  end

  def bottom_lists
    if params[:zoom_level] == 'County'
      @freelancers        = UserService::search(params)
      @jobs               = JobService.search(params)
      @events             = EventService.search(params)
      @companies          = CompanyService::search_recent(params)
      @community_manager  = CommunityManager.where(county_id: params[:current_county_id]).first
      # @community_manager  = CommunityManager.first
    else
      @events             = EventService.all
      @companies          = Company.get_recent_companies(5)
      @freelancers        = User.available_freelancers(7)
      puts '******************************************************'
      puts @freelancers.map{|f| [f.id, f.discipline.name]}
      puts '*******************************************************'
      @jobs               = JobService.most_recent(5)
    end

  end

end

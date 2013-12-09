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

  def county
    @county = CountyService::find(params)
    respond_with @county
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
    @categories = CategoryService::search(params)
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

  def bottom_lists
    @freelancers = UserService::search(params)
    # @jobs = JobService::search(params, 5)
    # @jobs = JobService.most_recent(5)
    @jobs = JobService.search(params)
    @events = EventService.all # replace it with actual data call
    # debugger
    # @companies = params[:zoom_level] == 'State' ? Company.get_recent_companies(5) : CompanyService::search_recent(params)
    @companies = CompanyService::search_recent(params)
    # @trending_news = TwitterNewsService::search(params)
  end

end

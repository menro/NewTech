class HomeController < ApplicationController

  before_filter :populate_collections, except: [:bottom_lists]
  before_filter :ensure_county_presence, only: [:welcome]

  def welcome
    @counties           = County.all
  end

  def jobs
    @counties = CountyService.search(hiring: true)
    @kinds    = JobService.kinds
    @roles    = JobService.roles
    @jobs     = JobService.search(params)
  end

  protected

  def populate_collections
    @skills             = Skill.all
    @categories         = CategoryService.all
    @employees_types    = EmployeesTypeService.all
    @investments_types  = InvestmentsTypeService.all
    @events             = EventService.all
    @recent_companies   = Company.get_recent_companies(5)
    @sponsor            = Sponsor.get_randomly
    @freelancers        = User.available_freelancers(7)
    @jobs               = JobService.most_recent(5)
    @trending_news      = TwitterNewsService.most_recent(5)
    @manager            = CommunityManager.first
  end

  def email_confirmation
  end

end

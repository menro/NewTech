class HomeController < ApplicationController

  before_filter :populate_collections, except: [:bottom_lists]
  before_filter :ensure_county_presence, only: [:welcome]

  def welcome
    @counties           = County.all

    if current_user
      countries = current_user.interest_feeds.where(followable_type: 'Country').all.collect(&:followable_id)
      states = current_user.interest_feeds.where(followable_type: 'State').all.collect(&:followable_id)
      counties = current_user.interest_feeds.where(followable_type: 'County').all.collect(&:followable_id)
      zipcodes = current_user.interest_feeds.where(followable_type: 'Zipcode').all.collect(&:followable_id)
      @events_count = Event.where("state_id IN (?) or county_id IN (?) ", states, counties).count
      companies = Company.where("county_id IN (?) or zipcode_id IN (?) ", counties, zipcodes)
      @freelancer_count = User.where("county_id IN (?) and is_freelancer =? ", counties, true).count
      @people_count = Company.where("county_id IN (?) ", counties).count
      @jobs_count = companies.map{|c| c.jobs.count}.inject(:+)
      @companies_count = companies.count
    else
      @job_count = Job.currently_running.count
      @freelancer_count = User.freelancers.count
      @people_count = User.count
      @events_count = Event.count
      @companies_count = Company.count
    end
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
    @freelancers.reject! {|f| f.discipline.nil?}
    @jobs               = JobService.most_recent(5)
    @trending_news      = TwitterNewsService.most_recent(5)
    @manager            = CommunityManager.first
  end

  def email_confirmation
  end

end

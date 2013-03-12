class HomeController < ApplicationController

  before_filter :populate_collections

  def welcome
  end

  def jobs
    @kinds = JobService.kinds
    @roles = JobService.roles
    @jobs = JobService.all
  end

  protected

  def populate_collections
    @tags               = TagService.tags_for_cloud
    @categories         = CategoryService.all
    @employees_types    = EmployeesTypeService.all
    @investments_types  = InvestmentsTypeService.all
    @events             = EventService.all
    @recent_companies   = Company.get_recent_companies
    @sponsor            = Sponsor.get_randomly
  end

  def email_confirmation
  end
  
end

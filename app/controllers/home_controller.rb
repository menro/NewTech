class HomeController < ApplicationController

  def welcome
    @tags=TagService.tags_for_cloud
    @categories=CategoryService.all
    @employees_types = EmployeesTypeService::all
    @investments_types = InvestmentsTypeService::all
    @events = EventService.all
    @recent_companies = Company.get_recent_companies
    @sponsor = Sponsor.get_randomly
  end

  def email_confirmation
  end
  
end

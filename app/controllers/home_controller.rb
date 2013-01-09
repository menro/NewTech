class HomeController < ApplicationController

  def welcome
    @tags=TagService.tags_for_cloud
    @categories=CategoryService.all
    @employees_types = EmployeesTypeService::all
    @investments_types = InvestmentsTypeService::all
    @events = EventService.all
  end

end

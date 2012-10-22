class HomeController < ApplicationController

  def welcome
    @tags_for_cloud=TagService.tags_for_cloud
    @categories=CategoryService.all
    @employees_types = EmployeesTypeService::all
    @investments_types = InvestmentsTypeService::all
  end

end

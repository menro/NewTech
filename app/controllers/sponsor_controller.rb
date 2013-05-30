class SponsorController < ApplicationController

  before_filter :load_service_data

  def sponsor_over_view
  end

  def thanks
  end

  def load_service_data
#    @tags=TagService.tags_for_cloud
    @tags = TagService::search(params)
    @categories=CategoryService.all
    @employees_types = EmployeesTypeService::all
    @investments_types = InvestmentsTypeService::all
    @events = EventService.all
  end
  
end

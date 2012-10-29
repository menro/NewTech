class ApiController < ApplicationController
  respond_to :json

  def companies
    @companies = CompanyService::search(params)
  end

  def tags
    @tags = TagService::search(params)
  end

  def counties
    @counties = CountyService::search(params)
  end

  def county
    @county = CountyService::find(params)
  end

  def employees_types
    @employees_types = EmployeesTypeService::search(params)
  end

  def investments_types
    @investments_types = InvestmentsTypeService::search(params)
  end

  def categories
    @categories = CategoryService::search(params)
  end

end

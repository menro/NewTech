class ApiController < ApplicationController
  respond_to :json

  def companies
    @offices = OfficeService::search(params)
  end

  def tags
    @tags = TagService::search(params)
  end

  def counties
    @counties = CountyService::search(params)
  end

end

class OfficesController < ApplicationController
  respond_to :json

  def index
    @offices = OfficeService::search(params)
  end
end

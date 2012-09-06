class OfficesController < ApplicationController
  respond_to :json

  def index
    @offices = OfficeService.all
  end
end

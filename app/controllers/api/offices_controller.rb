class Api::OfficesController < ApplicationController
  respond_to :json

  def index
    @offices = Office.all
  end
end

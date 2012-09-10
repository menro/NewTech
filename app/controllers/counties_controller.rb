class CountiesController < ApplicationController
  respond_to :json

  def index
    @counties = CountyService.all
  end

end

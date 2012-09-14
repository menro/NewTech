class CountiesController < ApplicationController
  respond_to :json

  def index
    @counties = CountyService::search(params)
  end

end

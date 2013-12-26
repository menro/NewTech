class StatesController < ApplicationController

  def get_cities
    @state = State.find(params[:id])
    @cities = CountyService.get_cities_as_options(@state.counties)
    respond_with(@state, @cities, :layout => !request.xhr? )
  end

end
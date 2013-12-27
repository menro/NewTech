class StatesController < ApplicationController

  def get_cities
    @state = State.find(params[:state_id])
    @cities = CityService.get_cities_as_options(@state.cities)
    respond_with(@state, @cities, :layout => !request.xhr? )
  end

end
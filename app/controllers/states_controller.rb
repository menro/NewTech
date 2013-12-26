class StatesController < ApplicationController

  def get_cities
    @state = State.find(params[:id])
    @counties = @state.counties
    respond_with(@state, @counties, :layout => !request.xhr? )
  end

end
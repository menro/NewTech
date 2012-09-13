class HomeController < ApplicationController

  def welcome
    @tags=TagService.all
  end

end

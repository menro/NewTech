class HomeController < ApplicationController

  def welcome
    @tags=TagDecorator.all
  end

end

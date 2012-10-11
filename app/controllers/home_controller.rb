class HomeController < ApplicationController

  def welcome
    @tags_for_cloud=TagService.tags_for_cloud
    @categories=CategoryService.all
  end

end

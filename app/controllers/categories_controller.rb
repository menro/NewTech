class CategoriesController < ApplicationController
  respond_to :json

  def index
    @categories = CategoryService.all
  end
end

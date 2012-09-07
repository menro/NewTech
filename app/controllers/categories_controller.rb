class CategoriesController < ApplicationController
  respond_to :json

  def index
    @categories = CategoryService.all
  end

  def send_category_image
    category = CategoryService::find(params[:id])
    if category.nil?
      render :text => "category not found"
    else
      send_file(category.image.path(params[:style]), :filename => "#{category.image_file_name}")
    end
  end

end

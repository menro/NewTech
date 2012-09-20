class CompaniesController < ApplicationController

  def new
    @company = CompanyService::build
  end

  def create
    @company = CompanyService::create( params[:company] )
    if @company.persisted?
      redirect_to root_path, :notice => "Company added correctly."
    else
      flash.now[:warning] = "Some errors are occured. fix it please! Remember to upload the image before submit"
      render :new
    end
  end

  def send_image
    company = CompanyService::find params[:id]
    if company.nil? || company.image.path(params[:style]).nil?
      render :text => "image not found"
    else
      send_file(company.image.path(params[:style]), :filename => "#{company.image_file_name}")
    end
  end
end

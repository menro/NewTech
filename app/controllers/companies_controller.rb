class CompaniesController < ApplicationController

  def index
    @companies = CompanyService::find_all_by_user(current_user, params)
  end

  def new
    @company = CompanyService::build
  end

  def edit
    @company = CompanyService::find(params[:id])
  end

  def update
    @company = CompanyService::update_by_user(current_user, params[:id], params[:company])
    render :edit
  end

  def destroy
    CompanyService::destroy_by_user(current_user, params)
    redirect_to :back
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
      send_file("#{Rails.root}/app/assets/images/company-default.png", :filename => "#{company.image_file_name}")
    else
      send_file(company.image.path(params[:style]), :filename => "#{company.image_file_name}")
    end
  end
end

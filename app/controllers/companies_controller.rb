class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:send_image]

  def index
    @companies = CompanyService::find_all_by_user(current_user, params)
  end

  def new
    @company = CompanyService::build
  end

  def edit
    @company = CompanyService::edit(params[:id])
  end

  def update
    @company = CompanyService::update_by_user(current_user, params[:id], params[:company])
    if @company.errors.empty?
      redirect_to companies_url
    else
      flash.now[:error] = @company.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
    CompanyService::destroy_by_user(current_user, params)
    redirect_to :back
  end

  def create
    @company = CompanyService::create_by_user(current_user, params[:company])
    if @company.persisted?
      redirect_to companies_url, :notice => "Company added correctly."
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

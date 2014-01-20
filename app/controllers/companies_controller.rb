class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_county_presence
  
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
      redirect_to companies_url, :notice => "Company updated correctly."
    else
      flash.now[:error] = @company.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
    CompanyService::destroy_by_user(current_user, params)

    redirect_to :back, :notice => "Company deleted correctly."
  end

  def create
    @company = CompanyService::create_by_user(current_user, params[:company])
    if @company.persisted?
      redirect_to companies_url, :notice => "Company added correctly."
    else
      flash.now[:warning] = "#{t(:some_errors_have_occured)} #{t(:remember_to_upload_image)}"
      render :new
    end
  end

  def destroy_image
    @company = CompanyService::destroy_image_by_userr(current_user, params)
    if @company
      redirect_to companies_url, :notice => "Image deleted correctly."
    else
      flash.now[:warning] = "#{t(:some_errors_have_occured)} #{t(:remember_to_upload_image)}"
      render :edit
    end
  end
end

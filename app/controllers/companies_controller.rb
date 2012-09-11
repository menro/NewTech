class CompaniesController < ApplicationController

  def new
    @company = CompanyService::new_company
    @categories = CategoryService.enabled
  end

  def create
    @company = CompanyService::create( params[:company] )
    if @company.persisted?
      redirect_to root_path, :notice => "Company added correctly."
    else
      render :new
    end
  end
end

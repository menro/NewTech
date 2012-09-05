class CompaniesController < ApplicationController

  def new
    @company = CompanyService::new_company
  end

  def create
    @company = CompanyService::create( params[:company] )
    unless @company.persisted?
      render :new
    end
  end
end

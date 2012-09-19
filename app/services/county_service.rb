class CountyService


  def self.search(params)
    counties = County.scoped
    counties = counties.with_companies_founded_from params[:from_year] unless params[:from_year].empty?
    counties = counties.with_companies_founded_to params[:to_year] unless params[:to_year].empty?
    counties = counties.with_company_tagged_as params[:tag_code] unless params[:tag_code].empty?
    counties = counties.with_company_are_hiring unless params[:hiring].empty?
    counties = counties.with_company_employee_type(params[:employee_id]) unless params[:employee_id].empty?
    CountyDecorator.decorate(counties.uniq, :search_params => params)
  end
end
class CountyService


  def self.search(params)
    counties = County.scoped
    counties = counties.with_companies_founded_from params[:from_year] unless params[:from_year].nil? || params[:from_year].empty?
    counties = counties.with_companies_founded_to params[:to_year] unless params[:to_year].nil? || params[:to_year].empty?
    counties = counties.with_company_tagged_as params[:tag_code] unless params[:tag_code].nil? || params[:tag_code].empty?
    counties = counties.with_company_are_hiring unless params[:hiring].nil? || params[:hiring].empty?
    counties = counties.with_company_employee_type(params[:employee_id]) unless params[:employee_id].nil? || params[:employee_id].empty?
    counties = counties.with_company_investment_type(params[:investment_id]) unless params[:investment_id].nil? || params[:investment_id].empty?
    counties = counties.with_company_category(params[:category_id]) unless params[:category_id].nil? || params[:category_id].empty?
    CountyDecorator.decorate(counties.uniq, :search_params => params)
  end
end
class CountryService
  def self.search(params)
    countries = Country.scoped
    countries = countries.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    countries = countries.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    countries = countries.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    countries = countries.with_company_tagged_as params[:tag_code] unless params[:tag_code].blank?
    countries = countries.with_company_are_hiring unless params[:hiring].blank?
    countries = countries.with_company_raising_money unless params[:raising_money].blank?
    countries = countries.with_company_employee_type(params[:employee_id]) unless params[:employee_id].blank?
    countries = countries.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    countries = countries.with_company_category(params[:category_id]) unless params[:category_id].blank?
    countries = CountryDecorator.decorate(countries.uniq, :search_params => params)
    countries = countries.sort_by(&:companies_numbers).reverse
  end

  def self.find(params)
    county = County.find(params[:current_county_id])
    CountyDecorator.decorate(county, :search_params => params)
  end
end
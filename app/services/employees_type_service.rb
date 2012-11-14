class EmployeesTypeService

  def self.all
    types = EmployeesType.all
    EmployeesTypeDecorator::decorate(types)
  end

  def self.search(params)
    types = EmployeesType.scoped
    types = types.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    types = types.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    types = types.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    types = types.with_company_tagged_as params[:tag_code] unless params[:tag_code].blank?
    types = types.with_companies_in_county params[:current_county_id] unless params[:current_county_id].blank?
    types = types.with_company_are_hiring unless params[:hiring].blank?
    types = types.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    EmployeesTypeDecorator.decorate(types.uniq)
  end
  
end
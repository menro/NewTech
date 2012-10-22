class InvestmentsTypeService

  def self.all
    types = InvestmentsType.all
    InvestmentsTypeDecorator::decorate(types)
  end

  def self.search(params)
    types = InvestmentsType.scoped
    types = types.with_companies_founded_from params[:from_year] unless params[:from_year].nil? || params[:from_year].empty?
    types = types.with_companies_founded_to params[:to_year] unless params[:to_year].nil? || params[:to_year].empty?
    types = types.with_company_tagged_as params[:tag_code] unless params[:tag_code].nil? || params[:tag_code].empty?
    types = types.with_companies_in_county params[:current_county_id] unless params[:current_county_id].nil? || params[:current_county_id].empty?
    types = types.with_company_are_hiring unless params[:hiring].nil? || params[:hiring].empty?
    types = types.with_company_employee_type(params[:employee_id]) unless params[:employee_id].nil? || params[:employee_id].empty?
    InvestmentsTypeDecorator.decorate(types.uniq)
  end

end
class OfficeService

  def self.all
    OfficeDecorator.all
  end

  def self.search(params)
    offices = Office.scoped
    offices = offices.with_companies_founded_from params[:from_year] unless params[:from_year].nil? || params[:from_year].empty?
    offices = offices.with_companies_founded_to params[:to_year] unless params[:to_year].nil? || params[:to_year].empty?
    offices = offices.with_company_tagged_as params[:tag_code] unless params[:tag_code].nil? || params[:tag_code].empty?
    offices = offices.located_in_county params[:current_county_id] unless params[:current_county_id].nil? || params[:current_county_id].empty?
    offices = offices.with_company_are_hiring unless params[:hiring].nil? || params[:hiring].empty?
    offices = offices.with_company_employee_type(params[:employee_id]) unless params[:employee_id].nil? || params[:employee_id].empty?
    offices = offices.with_company_investment_type(params[:investment_id]) unless params[:investment_id].nil? || params[:investment_id].empty?
    OfficeDecorator.decorate(offices.uniq)
  end

end
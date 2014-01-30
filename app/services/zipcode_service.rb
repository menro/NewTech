class ZipcodeService
  def self.search(params)
    zipcodes = Zipcode.joins(:counties).where("counties_zipcodes.county_id = #{params[:current_county_id]}").scoped
    zipcodes = zipcodes.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    zipcodes = zipcodes.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    zipcodes = zipcodes.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    zipcodes = zipcodes.with_company_tagged_as params[:tag_code] unless params[:tag_code].blank?
    zipcodes = zipcodes.with_company_are_hiring unless params[:hiring].blank?
    zipcodes = zipcodes.with_company_employee_type(params[:employee_id]) unless params[:employee_id].blank?
    zipcodes = zipcodes.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    zipcodes = zipcodes.with_company_category(params[:category_id]) unless params[:category_id].blank?
    zipcodes = ZipcodeDecorator.decorate(zipcodes.uniq, :search_params => params)
    zipcodes = zipcodes.sort_by(&:companies_numbers).reverse
  end

  def self.find(params)
    zipcode = Zipcode.find(params[:current_county_id])
    ZipcodeDecorator.decorate(zipcode, :search_params => params)
  end
end
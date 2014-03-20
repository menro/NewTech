class TagService

  def self.search(params)
    tags = Tag.joins(:companies)
    tags = tags.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    tags = tags.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    tags = tags.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    tags = tags.with_company_are_hiring unless params[:hiring].blank?
    tags = tags.with_company_raising_money unless params[:raising_money].blank?
    tags = tags.with_company_employee_type(params[:employee_id]) unless params[:employee_id].blank?
    tags = tags.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    tags = tags.with_company_located_in_county params[:current_county_id] unless params[:current_county_id].blank?
    tags = tags.with_company_category(params[:category_id]) unless params[:category_id].blank?
    tags = tags.select("tags.id, tags.code, COUNT(companies.id) as count").group("tags.id").order("count DESC").limit(40)
    tags.sort_by(&:code)
  end

end

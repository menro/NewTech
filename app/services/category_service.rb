class CategoryService

  def self.all
    categories = Category.all
    CategoryDecorator::decorate(categories)
  end

  def self.search(params)
    categories = Category.scoped
    categories = categories.with_companies_name_like params[:company_name] unless params[:company_name].nil? || params[:company_name].empty?
    categories = categories.with_companies_founded_from params[:from_year] unless params[:from_year].nil? || params[:from_year].empty?
    categories = categories.with_companies_founded_to params[:to_year] unless params[:to_year].nil? || params[:to_year].empty?
    categories = categories.with_company_tagged_as params[:tag_code] unless params[:tag_code].nil? || params[:tag_code].empty?
    categories = categories.with_companies_in_county params[:current_county_id] unless params[:current_county_id].nil? || params[:current_county_id].empty?
    categories = categories.with_company_are_hiring unless params[:hiring].nil? || params[:hiring].empty?
    categories = categories.with_company_investment_type(params[:investment_id]) unless params[:investment_id].nil? || params[:investment_id].empty?
    categories = categories.with_company_employee_type(params[:employee_id]) unless params[:employee_id].nil? || params[:employee_id].empty?
    CategoryDecorator.decorate(categories.uniq)
  end

end
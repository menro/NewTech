class CategoryService

  def self.all
    categories = Category.all
    CategoryDecorator::decorate(categories)
  end

  def self.search(params)
    categories = Category.scoped
    categories = categories.with_companies_name_like params[:company_name] unless params[:company_name].blank?
    categories = categories.with_companies_founded_from params[:from_year] unless params[:from_year].blank?
    categories = categories.with_companies_founded_to params[:to_year] unless params[:to_year].blank?
    categories = categories.with_company_tagged_as params[:tag_code] unless params[:tag_code].blank?
    categories = categories.with_companies_in_county params[:current_county_id] unless params[:current_county_id].blank?
    if params[:current_zipcode]
      zipcode = Zipcode.find_by_code params[:current_zipcode]
      categories =categories.with_companies_in_zipcode(zipcode.id) if zipcode.present?
    end
    categories = categories.with_company_are_hiring unless params[:hiring].blank?
    categories = categories.with_company_investment_type(params[:investment_id]) unless params[:investment_id].blank?
    categories = categories.with_company_employee_type(params[:employee_id]) unless params[:employee_id].blank?
    CategoryDecorator.decorate(categories.uniq)
  end

end
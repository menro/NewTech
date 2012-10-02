class TagDecorator  < Draper::Base
  decorates :tag

  def companies_count
    filter_companies_by_search_params(Company).count
  end

  private


  def filter_companies_by_search_params(companies)
    results = companies.scoped
    unless search_params.nil?
      results = results.founded_from search_params[:from_year] unless search_params[:from_year].nil? || search_params[:from_year].empty?
      results = results.founded_to search_params[:to_year] unless search_params[:to_year].nil? || search_params[:to_year].empty?
      results = results.are_hiring unless search_params[:hiring].nil? || search_params[:hiring].empty?
      results = results.employee_type(search_params[:employee_id]) unless search_params[:employee_id].nil? || search_params[:employee_id].empty?
      results = results.investment_type(search_params[:investment_id]) unless search_params[:investment_id].nil? || search_params[:investment_id].empty?
      results = results.located_in_county search_params[:current_county_id] unless search_params[:current_county_id].nil? || search_params[:current_county_id].empty?
      results = results.tagged_as search_params[:tag_code] unless search_params[:tag_code].nil? || search_params[:tag_code].empty?
    end
    results
  end

  def search_params
    @options[:search_params] ||= nil
  end

end
class CountyDecorator < Draper::Base
  decorates :county

  def offices_numbers
    results = filter_offices_by_search_params(companies)
    results.count
  end

  def offices_percentage
    # The base is always the total count of offices
    ((offices_numbers * 100).to_f / Company.count).to_f
  end

  private

  def total_offices
    filter_offices_by_search_params(Company).count
  end

  def filter_offices_by_search_params(companies)
    results = companies.scoped
    unless search_params.nil?
      results = results.founded_from search_params[:from_year] unless search_params[:from_year].nil? || search_params[:from_year].empty?
      results = results.founded_to search_params[:to_year] unless search_params[:to_year].nil? || search_params[:to_year].empty?
      results = results.tagged_as search_params[:tag_code] unless search_params[:tag_code].nil? || search_params[:tag_code].empty?
      results = results.are_hiring unless search_params[:hiring].nil? || search_params[:hiring].empty?
      results = results.employee_type(search_params[:employee_id]) unless search_params[:employee_id].nil? || search_params[:employee_id].empty?
      results = results.investment_type(search_params[:investment_id]) unless search_params[:investment_id].nil? || search_params[:investment_id].empty?
    end
    results
  end

  def search_params
    @options[:search_params] ||= nil
  end

end

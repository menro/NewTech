class CountyDecorator < Draper::Base
  decorates :county

  def offices_numbers
    results = filter_offices_by_search_params(self.offices)
    results.count
  end

  def offices_percentage
    ((offices_numbers * 100).to_f / total_offices.to_f).to_f
  end

  private

  def total_offices
    filter_offices_by_search_params(Office).count
  end

  def filter_offices_by_search_params(offices)
    results = offices.scoped
    unless search_params.nil?
      results = results.with_companies_founded_from search_params[:from_year] if search_params[:from_year].present?
      results = results.with_companies_founded_to search_params[:to_year] if search_params[:to_year].present?
    end
    results
  end

  def search_params
    @options[:search_params] ||= nil
  end

end

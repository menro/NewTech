class CountyDecorator < Draper::Base
  decorates :county

  def offices_numbers
    results = self.offices.count
    unless search_params.nil?
      results = self.offices.scoped
      results = results.with_companies_founded_from search_params[:from_year] if search_params[:from_year].present?
      results = results.with_companies_founded_to search_params[:to_year] if search_params[:to_year].present?
    end
    results.count
  end

  def offices_percentage
    ((offices_numbers * 100).to_f / Office.count.to_f).to_f
  end


  private
  def search_params
    @options[:search_params] ||= nil
  end

end

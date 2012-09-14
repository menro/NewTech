class CountyService


  def self.search(params)
    counties = County.scoped
    counties = counties.with_companies_founded_from_year(params[:from_year]) if params[:from_year].present?
    counties = counties.with_companies_founded_to_year(params[:to_year]) if params[:to_year].present?
    CountyDecorator.decorate(counties)
  end
end
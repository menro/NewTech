class OfficeService

  def self.all
    OfficeDecorator.all
  end

  def self.search(params)
    offices = Office.scoped
    offices = offices.with_companies_founded_from params[:from_year] if params[:from_year].present?
    offices = offices.with_companies_founded_to params[:to_year] if params[:to_year].present?
    OfficeDecorator.decorate(offices)
  end

end
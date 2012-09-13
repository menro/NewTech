class TagDecorator  < Draper::Base
  decorates :tag

  def companies_count
    self.companies.count
  end

end
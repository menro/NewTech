class TagDecorator  < Draper::Base
  decorates :tag

  def company_count
    self.companies.count
  end

end
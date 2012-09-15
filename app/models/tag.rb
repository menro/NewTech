class Tag < ActiveRecord::Base
  has_and_belongs_to_many :companies

  def companies_count
    self.companies.count
  end

end

class CompanyDecorator < Draper::Base
  decorates :company

  def full_address
    self.offices.first.full_address rescue "no address"
  end

end

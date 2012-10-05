class CompanyDecorator < Draper::Base
  decorates :company

  def full_address
    "#{company.address}, #{company.city.name}"
  end

  def image_url
    h.image_company_url(self, :thumbnail)
  end

end
